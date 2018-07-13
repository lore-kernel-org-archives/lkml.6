Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B558ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2F02089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="VoIZh89+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2F02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeGMQUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:20:54 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:54656
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729681AbeGMQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4qLQB7L5TM7EFhvh7phxbRv+phxCMnPArBJln0qgMU=;
 b=VoIZh89+CCvk/5RUWC5cwq4m4xXggXtzLcrZz69+PH3ffflKvSe26qBywwUaH22u5QOwuRvdWrg55nculPbYpthBMAzTKlFzH8+E6BDahAwuNy+uXFQFttKVmh9EEZCyhLRuicrcybgMnMKNZNzIkkkgQR4PZzlReSmBg01Bkf4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com; 
Received: from vmware.com (66.170.99.1) by
 SN6PR05MB4014.namprd05.prod.outlook.com (2603:10b6:805:25::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.12; Fri, 13 Jul 2018 16:05:19 +0000
Date:   Fri, 13 Jul 2018 09:01:28 -0700
From:   Sinclair Yeh <syeh@vmware.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Roger He <Hongbo.He@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ttm: use swap macro in ttm_bo_handle_move_mem
Message-ID: <20180713160127.GA14777@vmware.com>
References: <20180709152447.GA27520@embeddedor.com>
 <20180713023750.GA30532@vmware.com>
 <56e7e63d-f66f-194d-4f0b-3fb9642e7ff9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56e7e63d-f66f-194d-4f0b-3fb9642e7ff9@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [66.170.99.1]
X-ClientProxiedBy: MWHPR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:300:103::15) To SN6PR05MB4014.namprd05.prod.outlook.com
 (2603:10b6:805:25::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cccf03a1-7aa1-411f-9462-08d5e8da6ebb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4014;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;3:GqJ1Imb9KiXRsxrRvWhtorCWzPhD6AuCpHm9V15UqCDzVnaYJApJeE3RhcefhO7Dr372O9uEdthGRtNzJwtYGAAWuaiSQbSESf6WDqe3qWce/DlKmMkRY/OKzf1zKM0J/rida14dXax3WERLY0EQldMXB4H8XZVXKi4tOlWsQ8uzmT2XdAqSjgUcPUFHvVXnzn5XL/N4xQhzxeMqC79fVCBjsQSxDbp7qRhsBaw4J9FRe8lHl/Cyg6ZFoj0AUSBO;25:f7/7rYs4IW0AOQY3tgoFOXtqFjva+k3SOLmOrcMfxgNAlow4XEcc2ABVUavZPhTqcShNXfmd8+MjjW7Bxlz/dCs4EWZiVZXulj4NZYLBEi8N3rWDJyc1JZgwHv2DGQ0YQx3Q5ONAFhe+crI03y1CUusTQif1V4B7/RpDF7WwGHMIwOPoy4sf9qZGnGGOz0eyO58q1TtNx/a6+p0QXJZlWWVfWPBC9EikKvfOjWhl15Ez5r9XSNYLE/Zckao0jsF2TmTe4IcNpkePtuD82SrrBbKGjmIINjMcSCy9hIDS6BdMt3GEhXy6rxMNiEGDtJvlnGDATXiN3NhXiML96ptnUw==;31:UQwkRLoHlD1Lw6Qs7bSB7l08EKV8b51hgkPy2UoaEVXDOdRicqjE+clo8m6fg40r+WJlc7uRimSrW6Q4YIa/M1heE5wrfM5mF/LnLgHRSSLDhaQoVi08i3D/bOC38uyi6f6IJ7e7/bK58TFbfqeTKpFJdO9c253ihTAj7kx7VBwW0o66fss5/lMxSCWL38fOJ+SJYYDsaXguXJPVjElqShbgSmpLq2U47F73YTJ6jZI=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4014:
BCL:    0
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;20:kieAnPPsaKuUSPviBKiQhJCqOSx42YTd1DQeC4AeaQJ4BbZeMy6BognykoUiktgjXfpEN7gc/KraIYxHXMTFwL50AUU6WEaaV+Ee+PBC/IVwYCfRcpEsk8+DXr65Kqu4MvOwo7YBOuYFLssnQrNoVSveq9P0aKmojAuYmSKKFr/3G+M5kuNgHOfcFdVXyzjJZuB1QbJQHtMAJD45Yvh+/TlAT+EmnEDW89w8YlarJDhNo3iZ1jsXZHVjzrMP8GIUhQDBqxmiKTDwGRnLwDcHBmvpHtp67PfjuI1aOe4KzW1ra/j9eofSebOANOpCxA8IJvHbRGgMte3NPczB5BfAxZ2+4M9udNQv8vOC/Se76w4+z6bEMO1XJYF4fePdEHo4yJQ88suXYNFnJ8ve8ektIy6OzZl/oEzerQgY0kkKFNh18j5igPepFcveS+BMWROG/wCANPIuAIa7U49qhUZDW4Z2BZG1bqbXGrNoffW56DGPndaeV3ux7VQHx1g1X5NeSOWnUvYUjhSAamct8YLWFlzxSDhjChE2zQVv3rR4Int6aytbeAcYcKAtrk1v/i7prjngeMql00HSfKSpMPNTU+4GZR3P7eN8gvGciwT/zw8=;4:U86bQX/YUaTJWZhLRBygP0VJ1ulrvzDOd2tgK4C+ViysNIHlDJD4paogX9Sl11d/PykelRzC7ZT2O/DlvZybl1oMA65lgycNx5uu2FPUnCuoYPbh/+zj5ioAaythjAf6SAH1UMcvoC8wVOtD3Xypsui2NMsYIYWwsQT/04Oxs/7Ne7ICWPdPFxsVSP+wcoLJSIv5f/AEUMLtd3oS0wZmI1rLzDlPb9T2Uv9RNodaTbvJCrA9JJS1qSlV5KvWZe7z/Ey7hHz9Y8TpWa9bG588pg==
X-Microsoft-Antispam-PRVS: <SN6PR05MB4014550A8A7EAF47851E991AA8580@SN6PR05MB4014.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4014;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4014;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(51914003)(189003)(199004)(1076002)(11346002)(478600001)(956004)(54906003)(81156014)(25786009)(446003)(58126008)(229853002)(6116002)(8676002)(106356001)(3846002)(386003)(186003)(33656002)(486006)(26005)(21086003)(2616005)(105586002)(476003)(6916009)(36756003)(16526019)(316002)(55016002)(47776003)(6246003)(97736004)(66066001)(69596002)(68736007)(33026002)(23756003)(53936002)(5660300001)(305945005)(52116002)(4326008)(7696005)(76176011)(81166006)(8936002)(7736002)(6666003)(2906002)(86362001)(2870700001)(50466002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4014;H:vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN6PR05MB4014;23:tl/WH4oQ4C47fjgNoxIIufM2qVStyYI/YBAXXJN?=
 =?iso-8859-1?Q?cxmW/zZsu1LlAb9kC33F2gt3789eeSwAphEdSaCrO7LTur+1jGT9cn1QWN?=
 =?iso-8859-1?Q?C0I3N30g+sKIeE1eUJZWsRSyIY9SiBHciNSd7IrqukRg8JyC6quvZNBKdb?=
 =?iso-8859-1?Q?FMzSTACAw3frRDdBI0gERBJ22LAefAtN9ZX4q6VU1aseq/EjCKiALQBtcQ?=
 =?iso-8859-1?Q?RvEmLUWObv/CJhH6u28DREhCcHVblRz9lTEJbvDaUK4yRj8iWK5Irhm3/N?=
 =?iso-8859-1?Q?bxmupvEF4OhwoZJpzXy5yXNsN37gfMw/UDNCd87FwjmxW8Mf3S92oTwkye?=
 =?iso-8859-1?Q?aBeDQEE9usEbasiU9gEQ9+jKTtqPtcsahFxkh09V83HdhVfLcAAyCLBZqU?=
 =?iso-8859-1?Q?McuHzT+Gm3EFX0s1n1mYyvxXuqZhX82BWfvs8H9DN+mC/3D/1jNWt7+B7s?=
 =?iso-8859-1?Q?WO6cwX/H2wkeIO8RJZZiVLGvhHo8WFIizE9w5tn+suXlG/Htu3p+KH9vmY?=
 =?iso-8859-1?Q?T9dSjpNk9FYNT//3/l/FzXhF6yZkhZwHylIwyNoMlmfD4nnRggZsYjB+r5?=
 =?iso-8859-1?Q?b+fxUUunpHX0X0xJQvXqsxfW3M1Bpw/CTvLe3nfkErfLoi0Hp8PSE0avdf?=
 =?iso-8859-1?Q?zcF9NjR0mSQomyzCadC0eeWLUQP/4eQrlc3fRH4hrL1uegTxUoojz/fkey?=
 =?iso-8859-1?Q?DXIZmZbCFvP1Dl7U5/f9d5jWFOh1aRloT8MBjnAiZZ2VNlFYsSWw04pwuL?=
 =?iso-8859-1?Q?Prt3LZAAcFBvdHEJBfkwDpYw6Lo29h+nIOZ4OhsAzd7AlTKBtmkeYus/wg?=
 =?iso-8859-1?Q?AtZi9/JFUw0MfqHg4J5MnCKwbFQ2lWNm5Liq1ehcA42W0iwAnG3weboLQe?=
 =?iso-8859-1?Q?fjaVxOZRlwtpRZYeH+pV9Fg/fKO4sGFMMLcr/skHGGYuVKK+yGdFXuIp5E?=
 =?iso-8859-1?Q?Q5pAVzc6AB8AVBvhrmDxerU1MlOEZdbR4ypE3ce2Jky+UpM4CbtWQEgRst?=
 =?iso-8859-1?Q?0s1YyYlX7ddvCkGurZNeB0J7WEx52OAOKtrYrhEBiDsqOwMKnAZHUbVH2e?=
 =?iso-8859-1?Q?satriXhK/YZZmqI/aZMLl1SKDsshF5eVLYyyRYZwUwv6Y+jP/HBi10dgBd?=
 =?iso-8859-1?Q?7WBzrX6XH25e6S6Ka/73OuNfw0aY/nFiEp58q8BNT5HN7/aPyCFCfmHMF/?=
 =?iso-8859-1?Q?E8s4S0QRDaEjcZxum7odNDwyb0Kuvq95LHSQuzEsTXWPRzeuWXoJBJ95sk?=
 =?iso-8859-1?Q?9q9un381sTvP5rJwr+3dJ4QWiWLK8NcIqP4zPU7MoGk3HU/fCIagL8FK48?=
 =?iso-8859-1?Q?s98JhlHMwkeBBhjyQTmDqLXfCsYTgjIhS8k5pKwnaR5DW8tj7EdSyHdTPd?=
 =?iso-8859-1?Q?ZRA9DsfDj2oQg7KWuy4xLVBpRLIgB64MXW7Xe57SqWkSXH5VJdQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: xN1JMDeOD86rM+Nn8v/S/BjdttTFXoLu4fcbCsJm18sGlUwuznoWYRS7YG8vai5UgRd3DHUU2DgA1uSQ3forWymBd3SkpEWEsIdeYtwhmaBLwLZQouCC6exjtmbA8dDOVo5NEBEnNk5fOjTiCiG6ib0oxl5Dujyvh2Bt1AYc/X0YUmWPJ3qkQEERaUZawHPE/QfgqB+iuDBp2Z3SUCIZa95SFuQJ8A0Hfj+oHvqjEOW9uT5N0RvXVOefSWNy5Lgx0KJGT3HmI+EVAW+akcuLLOlXnr1FRSShvs0s3saqOc2A/uSQ4JNNWvqNgPifYBgfVnCZLL/Lyp1X1XzPI5rICMsOpFYnV9jwe1O8ap89WN0=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;6:3UTFeT3vgYSmS2KRR+78ko70q3/amEvb8Yc4ji9ugIAtqhe5VbZyOy4evLl2osugb7qJl9tkEOtqm90f2ENvkGhnWL4QGZejqdcFjRrh3H1EzXh2FdIQB2UKcVH7y7jfNjbLeG4mMSrYwGnRQPpHPZ9NalIL6RfG+ZUMKZAkP5WTdAKCtpG6c5bmhAaUr9VgKSkQ6P77rjU6+Q9Ejv5H8L3kqz5LqywN8ne+hwV83Z5L5F+qOh3qITKIGWVl3RyqMbh0KdDBqrpbXW9oZFk9tSU9biVtN3qqploghd5ipK9j+2iaLUOTowQOKgz6KvtnJv4RDATOPTk/1zVym697F6JnMiqOw/oShuACR+Gdn5gpC7ntNfEs0cTbqgjNJWnBl06J8NyCWc/vPo/ctTvbpdK8pEYyFPR5Edvuti0mDnCF0wKUZJTTOowQ3cjGEuhKInjT0EMb1QYe+O0mE7V7Og==;5:7dgkHmU1cf+VL9NXowV8bk/U+AXmpnds9NaQsqWgvDBdEOXoNsj0a3c/CK8sG8GOllL8V0UthHBPImQ5juBte8KH+uwXZt+NXWVakC7slm/YErvlVucpnoxDQZ3S0WH1rLO/wlph4FJ+THX+DrF98SYm4BTLvCrpjNN/0O/ABl8=;24:nO2zAoJDQuYRVAAm6hm6e5URaTMdxwb/V61D522GKdQPdvBCw21gJ7cV/fff7p1C0ZRZkGXbgWASuU6uqeD9eMRg5rofNz2vo/PdRkPvklo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;7:w6pJkzPhOd0MaTTcCT/e6p+XsXRGeDIfFxJU2JC0Vbi0LzNpu/oGPO6adKyT0h+MkczgGO8+hHqzWkcD5Clzeabd2IJu6vgup9Els1EK72r25Bc++1xNH9rMM+rhrK1xgcxDoUN6OYbtFpEoIrsG8rnas+0HrjoGHabLcVWtAa7BdFZtEGIvQFPdv4ZKClN/QtmJ7MIavptNVurD4v5DwgUmmhJISytUm6H6Qa973ho2NuXURjU+SriWx8qh0ASO;20:8rn24VAG4K8VEoOB6Uc5ye79qBne+9jxP5b9OiRrC+oYJ3FVW5cS5li6SoAZI0OL76NgR0iCTbsQAzs4D/3yINsln9ZKUKmcImcCpejyNyoP58Gr9CWOKjWpuZVPDnCFJd71DrRy+p2i8RuQbMHVZGO9emUll30llv7xO9+eOYY=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 16:05:19.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccf03a1-7aa1-411f-9462-08d5e8da6ebb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 08:41:37AM +0200, Christian König wrote:
> Am 13.07.2018 um 04:37 schrieb Sinclair Yeh:
> >On Mon, Jul 09, 2018 at 10:24:47AM -0500, Gustavo A. R. Silva wrote:
> >>Make use of the swap macro and remove unnecessary variable *tmp_mem*.
> >>This makes the code easier to read and maintain. Also, reduces the
> >>stack usage.
> >>
> >>This code was detected with the help of Coccinelle.
> >>
> >>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>---
> >>  drivers/gpu/drm/ttm/ttm_bo.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> >>index 5d8688e52..5142dcb 100644
> >>--- a/drivers/gpu/drm/ttm/ttm_bo.c
> >>+++ b/drivers/gpu/drm/ttm/ttm_bo.c
> >>@@ -287,12 +287,9 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> >>  	if (ret) {
> >>  		if (bdev->driver->move_notify) {
> >>-			struct ttm_mem_reg tmp_mem = *mem;
> >>-			*mem = bo->mem;
> >>-			bo->mem = tmp_mem;
> >>+			swap(*mem, bo->mem);
> >>  			bdev->driver->move_notify(bo, false, mem);
> >>-			bo->mem = *mem;
> >>-			*mem = tmp_mem;
> >>+			swap(*mem, bo->mem);
> >This code assumes bo->mem is the same as tmp_mem after the call to
> >move_notify. Is this always true?
> 
> Actually the old code assumed that. Using the swap macro now fixed that
> little unclean implementation.

Ok, thanks for the clarification.  This looks good to me.

