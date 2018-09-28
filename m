Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CF22173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cXyHxNfq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zn0EbZB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CF22173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeI1RBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:01:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729228AbeI1RBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:01:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SAYiiP000304;
        Fri, 28 Sep 2018 03:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=m4y0AP68e+ELZO9jS/VEaMD7XwupQURc4Ga+tj/iDu8=;
 b=cXyHxNfqXg3O3DMuf5eEiN8USyHue7+qs5MApsNVDTm2+Fsun3/2ymQzKuRdVFD29L81
 xDg7pmvH83qJf4h+6VZrDHxAec0gHex3jmcUMwN26irr8CFcAKNscPkhT1KlFBvl9oNq
 skthDBMOT5pb/6zr0SDd8LotS8ZbP+jR4R8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mshdsr7qd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 03:38:07 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 28 Sep 2018 03:38:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4y0AP68e+ELZO9jS/VEaMD7XwupQURc4Ga+tj/iDu8=;
 b=Zn0EbZB9EFFAOrgedz5yCW1P8f+yP2axMkpMpHZ1jbCQTFgrqCr0SCUgyoD8lr0YMZR5i26VBq0OmMUQA5aYKQuG0tQ6rGZQSf4tUH07gFd4Rl5CNC/O0ODhTh+AW7VSF3K0oWHiA11LjnjHOkjk5PSm9pryYT8mtsLZjsL4Em0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c092:180::1:82da) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Fri, 28 Sep
 2018 10:37:37 +0000
Date:   Fri, 28 Sep 2018 11:37:26 +0100
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Message-ID: <20180928103717.GA12917@castle.DHCP.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-11-guro@fb.com>
 <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
 <20180928100817.GC9018@castle.DHCP.thefacebook.com>
 <20180928102814.voj6bsuslxh6ms37@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180928102814.voj6bsuslxh6ms37@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:180::1:82da]
X-ClientProxiedBy: AM6PR06CA0005.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef36137f-b653-40f9-aa25-08d6252e6a64
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:N1r+TJpPudt/j9pqe+yjhaEVeT6tuY8QgPj4KH3gb7Xc2SWLW/0FaffS853lOyUfh5iwBtEoXcAl27QLaWvyNX4ifOgXrP9kXrPGmNVvPm5t/x5qBYO02z5HT/SBpMj/15AIKJMHtRCuMlZFVQMTdalT2ReDhZiPEIl+EgUVVtmAbB+qQcN3vmKgmA/DLWd3wUREnKO78XlhnZynHOsNanGs3TgevFW7Ncrt5klmvKCcD4/nIYeMC9wmzgN5yKbV;25:MCPECiE+9ethPzKFFwEnBLCpnlUapbBtPPNAwyEK5oesc1qUKv67Je2INw7LJvvSN7WbalJ/5NgF1aQm7A8oVhlUgyDOmXgYUAnHCAeZ9hkaszhT72TlkWY2yzO9um0DXQmUbu7Tq5PuIkjn1jU7GdPgRQyj7j6PumYALp9ySHn72e8ndhqQHJqt7PeTmqlb4gc2JQCPlsHosB/jzcsuEYPijrMSbCvcQhpIdPRpFqK7e6jaRznhVpZwDR8pNy7BHO/nSxwGWYZTCLxPASFf/h32UKAGeRXqG95TIV5Th0BTOSo+Sup2vLVn+4AH+iGdrtiq2Qs1ijXO1d1Wbx2+uyhpKc8+T4thmynMPf+0WlE=;31:+eGLlprUTrqatgSlUXVYMZERlG6amDp1kImUf0ee3lDdmZjFttNBaUnXOCMfe+w8SUQDhhcxxB4sNnTZg/TfLSIFGAUY7m7IszDdo+5oQ4QseaFSc+hN15KvwsWXxxcuBI79ZjAzPom7WvXIGnK9Wqg04if2aRood+ZOCj07h9Bj6JjNk6Tu12QD8rDHD0aoY/MTIX4s22AexsGnQUErBPSgmHd74/2ArQi3t++YAf8=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:y5oQHlmWVlqZjA9kaHjDBhFOVI+xOwZqzqZC28BEbdiiL1OMljRVOhNOjH9t/c4eVvIyiTIO77F8mABNYZslKsh8lLoRYkuQ4O62XyxilB10q5rDtF76n3tKXhHyYx/gJ6eG0xD5iGhpE1OWLUqlq5Fp8lj+WwHsYOWatDL9sdIT6Eu4f5wXCspSGRj8903ZS74dYSulUl0hW70nSoUvc3/RLoGLiurz+faU4ZLbvdbFpqefV1+Yv8XknX73zj69ePKxdOb1wuUhM5aGEoUUWfE7hoXsX0EN8oDBAVrw8TU3WKp+wMK1VlbYhmHFRg5vjfuBI60bzt6DcLqIeLoQX/dSelrFZGV/0Hk3gEMbIk3ljBqPtgxP0/LfQQtibCbQZrvJFF3h8HDsTWQxwDmYQjkr/EwudJE06BBtBHgCdgUCGZG/FexFT7bGSHaRP5bFKlRn2yF763gJD0RdbHb9rCkeWpAl5eO+uIahvRjpzXtnMmTKi0W3gv2NMKpB2fbh;4:CCl8ZVKqflfUJhT8GEID+kaUOMuzUQSaEvpsTwf+yfC35S8bXkx545H5pe1bMmVnir0ZHPV7YjSGKGMwbNfRjdVdCn8Nij3uGxQ1qoyPOXoQQTyHgqWSE2jyeWbIApaHJVEWWKqwls8DpKNlybHhMGcyhVQQ0/8G/qybutGLB6i8q80CPv9mk9nin3XPG9cnDFXASSs8DeDK2o8AeUQ6yeuU2Ef4MXdq0jCNSbvjJB658lVhNJhYs8xbZimLVk6aaByFEEwSoR1RN9Ork1CtEQ==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162325F4E751F28962E718BBEEC0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302061)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(4326008)(2906002)(105586002)(486006)(97736004)(106356001)(7736002)(476003)(46003)(68736007)(58126008)(6506007)(5660300001)(52396003)(16586007)(7696005)(16526019)(186003)(316002)(54906003)(33656002)(386003)(1076002)(23726003)(11346002)(305945005)(6116002)(52116002)(446003)(76176011)(50466002)(229853002)(47776003)(8676002)(55016002)(53936002)(8936002)(478600001)(9686003)(25786009)(86362001)(34290500001)(6246003)(81156014)(81166006)(39060400002)(93886005)(6666003)(6916009)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:z17YORffX05xSkN+wPRMMLDOfSRdFkruca9otlu17?=
 =?us-ascii?Q?POYWsfFekVzZsZTE2xQnui2qiQEPuQyxy7a4yzD/yKsoyigcVDNeTkMyVdF6?=
 =?us-ascii?Q?Z3hAX349dSQ0BNPLQ+/2OrbMRCvibwuE66ENgiZBZltjd5isbIKo1S2vxEBx?=
 =?us-ascii?Q?0F4isaeQmiFGRAJTlOvJ+oa5SggFAzIsAc/kzORumMl5qRDonNMCiOLUpiXJ?=
 =?us-ascii?Q?c+RXtGdMflc3f/tStqFX3YqJbPGw60C7ukZcb810z0tvi89JDwnYzv6pqkWc?=
 =?us-ascii?Q?DcMFrr4dVGMhnLQ19YV6qzwetz4RtlJLYwDL3mkI2bYNhwfyBK41E04Bf7ma?=
 =?us-ascii?Q?LfiTLrENeifqsWHeQ37Y8cmc6b1aSQ+/RRnQW0MSn1UJqUYzcTml7nxEGKED?=
 =?us-ascii?Q?FYU15Sf0dWB6lxtmc3hxN+UpprTYGuQnLHZD+vd2wwFHuMMqdKBFDmxrKRAa?=
 =?us-ascii?Q?RD07d1gnqrWWTbVgYTqEVkl7ZKsnOMddyqZJ/xiMzwOz4ZOUhdFQy3HxQ/gW?=
 =?us-ascii?Q?tPx8a1cQs1dDHbxKrPRrvkL4OJbnFnzAFWG1haBDErO1IMJy/HZ5f/0rebKd?=
 =?us-ascii?Q?EnsQM/Z/n/CngAN9zGbol1x8jpMGwzjruiQ1+lcMcDaZezClbpCfG8riwh+G?=
 =?us-ascii?Q?38eFZlSfD8sIVpAGgdo6LpVz6gIN5XaVmB0B0DpWl/AAes23th39zkXrmspr?=
 =?us-ascii?Q?2Wnb0fOpVgWiB0zsNAWw1HpC34CtL9n6hHFzVFBkX+GnETAK/A2wXhha1Vvx?=
 =?us-ascii?Q?s1i5yAq/CeQUcvftwI7Lu+Pw/AdI2TZtMjFs4oIFEZ7LBEEkq+5CP7FJiv7G?=
 =?us-ascii?Q?ay1Dj4+Gr/QJkxlZIek0SLfj3cwVBGgb5cGBCulfFw85n3UMv4BqcwSlXO1b?=
 =?us-ascii?Q?StcOuDH4c4ojNLlN4DuLloJRmTbRHD9slZ0VvZZW6ssbw0gqN7/nJG6vImaL?=
 =?us-ascii?Q?uUk4km+jnlOUDksRNogATGRZ2eoIwIH9k96bJZcKoVC7hDOMtsH91dHHu1//?=
 =?us-ascii?Q?SCQSLEGdmIWNSn7jZpODXwGXwo49dItbfjSvnaHTE/3irC/h1eYzRdX3hTlL?=
 =?us-ascii?Q?kOfBQyxMIVRh7tfJ0PaQ1vd9vwdjuta4LXwDKt3HJm+yBQTE1sk0moZV77b6?=
 =?us-ascii?Q?dh4kcSEAGMOp4dqtCFKNkvw4TWWkRugH49ZCS38ew5VlfyhkfhXtV6rFPS55?=
 =?us-ascii?Q?7/PjDl9QK0rdfhYjyIBDb/homkVTrb6arP4GJVCavPUPtCbuRHEZYCiyjnho?=
 =?us-ascii?Q?3ZLHtuM2FnPc83z/wFJIz5VIGW/0ZgJJkkgE5j7XgGwI92cnJvHh9tsZNdwj?=
 =?us-ascii?Q?ZXLOHm4qdrZ7/1TwaTeQr4=3D?=
X-Microsoft-Antispam-Message-Info: McHpE4i4HsRtJeaV7TMQgwWSSQk+6xff/5/TMMvwPP5Z6syxlIg17aLnurtnlL+E2Pav7cYV3UB1ca2fJ6AhBoHSjeIDH8noO+9LMriguU/l1ZY5BLUAWGVDeUgA5QPwJZYPyjpES9cDDpOELVi9hQtVJFkv9pFev9wzKgCf98XLC8O35MXjhpBbuAqri2eVCNo/H+uCv4HF7qxGoDLZEcxnuMNnh7QZ6DOH7r1O/g4cKMYGwdtqEGPPEg7D3ti7PandI6VrG61v0J60e8X2GZQUqcobbJCNt0qXejbGHmS7zUdCV08lhwT0NMHHx0IbmuncuhpOy9QkOWzmiSeGhcZgiMtpEzLRtERzkVDEeGw=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:dkWVP8XwvsI5xPjb/eavcKS0Q2uu8+kGowuiLhhHVdeAP2oqEtegdvPmubyB5ljgkOD3k5W9ftudREZxYNK+Kz/B+ZLLUiOBW38O0AbnHOfxnJy1oaYIKEGNOApayPEW2qBlKT0+aZXJn1ojaH1ZrgdBHR92Q2bep395+vIEVhBMsE2H3nxIgoYM/sMKF4JdiX3NSDCwayJpTijqizb8XOdCQo/QyxnP3/8wJBrxrDZGR0j7LjB+16cseVX40ETE2OcZ2jDMfUuRFDTnU2buTMb1eyHbwsRcjRRFBfTAGEiFtZpBRUNxkS5WNhjnGaKsGGgoMMyFR/jzmX4/uo1vI3xTeaN+Cbaz02hD/nRJu+V7lohVl8Ci3vEGgPwpsMyPX1KmIfp9vfx37vcY6wnCbvo+qPqZ4xwXxbVMhDY9r1A2R8f35cqLKfHMp6wbU9psAbJjJW4EclsEjMecS4Q5wQ==;5:tFs7RJ3ycKGahAPo3m6005ZbFzawJyL0hBQ4ui7D8XFzuJwU5evayYF4S3gi7+zpGhycRoxALFObEcHfP6t8dZK3XtLY5EOFcfWSTVfLnRzFWVf+z5JNVwTXtrW2VczGSvEt5lPikyouJUM5QwRxdvsxusRPIlVl3FA6A9p+F1s=;7:x6PXb9fgAJ9pLsOoWxkDqrlmT59aiCchPKOpeA+CjzeGYej0zk8u7kmKOwMnFoOrmx1nD78E+myyPWjUgjk0gS+apMAMPUank4XlgRTfmN9B/bYwxF+8NA9fSWakozHk88tuL2vpJ/F/alPja5FBDr1oH15lAk53OviiwtVkEa/wIjy54fMi54qMy2etXdcxayNgrDJLQ86CHZZ1VktsPX6luEQfMWAQNIjrFY6XX8ZSRAeecLdzgBvMhMqWIm+F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:9gQr8Hl1mq7YB2Y7EQ4lbAgkod2PTIImo1aqpqWnt/UckpfsH+98mLIeF37wIaLedO9vLEYqevAvEWfv8CDolFA19RfLx/hnvqm07H1JIapJoYwMXMMnp0ISYxnbv3t5IhVfN/o0Ljp0f03jVUs7TrKnbaru4bOxPN5Ykkm/FHM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 10:37:37.7278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef36137f-b653-40f9-aa25-08d6252e6a64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:28:16PM +0200, Alexei Starovoitov wrote:
> On Fri, Sep 28, 2018 at 11:08:29AM +0100, Roman Gushchin wrote:
> > > > +	/* Some packets can be still in per-cpu cache, but not more than
> > > > +	 * MAX_PERCPU_PACKETS.
> > > > +	 */
> > > > +	packets = netcnt.packets;
> > > > +	for (cpu = 0; cpu < nproc; cpu++) {
> > > > +		if (percpu_netcnt[cpu].packets > 32) {
> > > 
> > > pls use MAX_PERCPU_PACKETS in the above check.
> > > could you also double check that if that #define is changed to 1k or so
> > > the exact "!= 10000" check below still works as expected?
> > 
> > Do you mean adding a new test with a different MAX_PERCPU_PACKETS?
> 
> good idea! If it's easy to compile the same source twice with different
> MAX_PERCPU_PACKETS that would certainly make the test stronger.
> Not sure how feasible though.
> 
> > 
> > > 
> > > > +			printf("Unexpected percpu value: %llu\n",
> > > > +			       percpu_netcnt[cpu].packets);
> > > > +			goto err;
> > > 
> > > > +		}
> > > > +
> > > > +		packets += percpu_netcnt[cpu].packets;
> > > > +	}
> > > > +
> > > > +	/* No packets should be lost */
> > > > +	if (packets != 10000) {
> > > > +		printf("Unexpected packet count: %lu\n", packets);
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	/* Let's check that bytes counter value is reasonable */
> > > > +	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {
> > > 
> > > since packet count is accurate why byte count would vary ?
> > 
> > Tbh I'm not sure if the size of the packet here can vary depending
> > on the environment. Is there a nice way to get the expected size?
> 
> ping packets should be fixed size depending on v4 vs v6.
> If 'ping -6' is used, it will force ipv6.
> 

Are we ok to screw up kselftests on v4-only machines?

Alternatively, I can send 1 packet, get the size and check that all other
are of the same size.
