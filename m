Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB9ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="APZ/seJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeIRPYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:24:32 -0400
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:53088
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728913AbeIRPYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5b94b8+1RLnQlwnip/aBae1GbLn4z+e3jeOdM8xcWE=;
 b=APZ/seJX/K3jqb7WTvVOqWLl/Atp0ucG0qi6WE7doP5+EqfQ+5OPH8gtVauhE/Q7+YIyfSXBS9uFP02VRPiOS8EchFHoJM6BUQTBrqRQ0+MuqxFM7K8lHm8xnpejeh0IPzD8ixGSM3kppXwjZ3FVgoD3/pBWtt7aYWghORdOGxM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
Received: from rric.localdomain (78.55.226.144) by
 SN2PR0701MB1005.namprd07.prod.outlook.com (2a01:111:e400:341a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 18 Sep
 2018 09:52:37 +0000
Date:   Tue, 18 Sep 2018 11:52:27 +0200
From:   Robert Richter <robert.richter@cavium.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
Message-ID: <20180918095226.GJ3795@rric.localdomain>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
 <20180917172206.GA3795@rric.localdomain>
 <20180918083805.GB14404@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918083805.GB14404@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [78.55.226.144]
X-ClientProxiedBy: DB6P193CA0014.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::24)
 To SN2PR0701MB1005.namprd07.prod.outlook.com (2a01:111:e400:341a::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f11fff4-4b4d-4e75-cb94-08d61d4c77cf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN2PR0701MB1005;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0701MB1005;3:Zsq9UM5n0gcKn0rwD21aug/G5iCipdG24kCNHpQQRVVVZpvn4DwseMObVop1BiM+jcIAlbiT/QjC34/jMOzLdBLi5C3tZeoCaL3rFlituYd7ZEFIVaQ1prmuKYJQY4O1Snx+wdMTOEF4nVUX3/PkINSDlDLm/aqsRfu8rBdgoR268RCdiXZLNPu8x2GxWdMFMUneExOscrsufnnEHywUR5rZUzHzgVTzfAdt23e2DFqGbY4mPHKdf+KizpVENSSG;25:qmVCLd5JEkPOmLkUvAVdCji9jD33DyQixKO8AbIpJ0JLHpAozr4reWutYogurw6B835gLeDqVHacC3HgVyT0kdbRwO6he+PSJ/0d+uVXQcdSo/J7Mvfc84hQHyjuZvKCCLegqFpfRXlvo0DDyevW6XimyYzcFGmDMqplykRWd54+w8jyL5BC/EpCvoxzUVsADwn6kpXapBcf7FHjOVx5pnJ1JQB4XZRZlXWemQ229HoJeheSs4qTdIlTqpj8tmaO4wB3gbiz3XAJ0OGV1XfvQMHGpLpo9enODyqkdZZW565A7kAsV5LdrQMXCVDk7STbrnfdAgLXKU08UwOUX/T0wA==;31:IYTFpcHP2/xZdhs5OWCglUo09mIEJgDDLISiw484I3dTbzJWJa24xil+6CG3LHxuGW/BxCeQ6lnoh84RWsjhtFS2tgZvvs4fGzUWXhxSAKU9HVC83NQS4TehE+baVVQVpjVEs0pSx5KpuSSMyOsp2NagVaJIOEbFDtAuUsdmJ2i9ByyELXwjuZkaiF9xxEXXxxtCwIxHIzZkFKrDf1sp9V6qAEf2qxx6+p7K+jaoODo=
X-MS-TrafficTypeDiagnostic: SN2PR0701MB1005:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0701MB1005;20:t4dlmgWw5W7q+2XdWLUMbJk3Pm1NDVcq00V7F6o6jfSGNIuQLYRPcsB+ytrMkofIVJXfxbkBzj/ns7JNOVdM5EWNqkIlM0Yde37OFqT+YI6hIFcamPRMk9Kq85ffD8Eh3hfBjJsHAELThmufAimWo1UIjFHjpcy3QBzIu7ErGOyTvG3WakIqQA069ARnblc5mmaJRVn8Oxpj78J6YONimwnFk7O1wQs5eoehsuB/xcwl6V5TzfRm/Y7Ia9wv/vhW8yTb/QmD3thNRR+VYMwxkgUzJMpT3q4Ga1JBIoqf/rc/BzrG7zAePOCxPU/vzZQIFdpXijAGc7Tc0kjGSWQm027w9QqliiQI5luu07v/KR0P7H1ntbt5BbPlQmrXc1e5TUVEMoFIsPq1tUbmS2MZ8tjdzzt3+M3s5gGIk9MCu/z37gFDeWB5duuXiQw+ifJaMGkkpb0hjNhik8cu65QlT7/twy7U0C+i1/nCMLkuAcRro3iowMMo+ZwseP2Ti4K6;4:9zJenSF6c8IkwzuhatZ/7zSETTb1MVU+6irFctUcT6V/lRTXvVrhboHHeIgrK7yN7ovZ6jbJWBf2IkPMhhe3qViFRiKPJmB3oU77ijg4sY/vvBllgvOoLyQuDCWlE2QlkxMIMA6yvcxzLBnyKJWdxBMFWB0cZ0IoFDA0hj1v8ti/wQVueC/aNrRHi1FLusi7D9PO2pri5BZfeczbRsg0Raq3fzvsal3EKKTLrSSLFMl9fc9ffO5WtYtLAdRVfH27DvWHDza5x36+CJcvvoTFsI0k5jFfdQJGSG860DSVKadPzTW4sWWSt46JkIwoQr+u
X-Microsoft-Antispam-PRVS: <SN2PR0701MB10050AB7172D9643677899BAF11D0@SN2PR0701MB1005.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN2PR0701MB1005;BCL:0;PCL:0;RULEID:;SRVR:SN2PR0701MB1005;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(57704003)(189003)(186003)(76176011)(6506007)(53546011)(486006)(55016002)(9686003)(106356001)(446003)(386003)(6666003)(66066001)(7696005)(7736002)(5660300001)(81156014)(52116002)(93886005)(33656002)(305945005)(81166006)(6246003)(53936002)(105586002)(44832011)(16586007)(316002)(8936002)(50466002)(3846002)(58126008)(97736004)(11346002)(6916009)(4326008)(229853002)(25786009)(8676002)(68736007)(1076002)(956004)(72206003)(26005)(217873002)(86362001)(16526019)(478600001)(6116002)(2906002)(476003)(47776003)(33896004)(23726003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR0701MB1005;H:rric.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR0701MB1005;23:Bn9nwXxkfgGJblUtYEUTe5RFlwO4montB+wYoIx?=
 =?us-ascii?Q?kYoaOZ3zoHqoY/NqtLuxDR5u1FzsVP1NOM0wBVxsq6jkypvfb94uQsRom1Si?=
 =?us-ascii?Q?LYNZ82jql+m/0Ox0Ep5u8Kevo7OM6tJj9Pm2a3J5d1ZDW3iFoxGybPCWxxbO?=
 =?us-ascii?Q?vabmodqlpwvP9tNouKjqlhAtEwjGVP+oOEQzkF+v2NQeMXnJFkcJKgaRyXfq?=
 =?us-ascii?Q?OzsgTcObAti3hOOmfwaTPnUxeMbm63u44IszOB569cp+v7KSA2ApsZRuqWMb?=
 =?us-ascii?Q?3zjubNKEavzohLTywH3DRcx67S1+PEOVNUzmDmWh/S/7S59DpdEK+53z8GBr?=
 =?us-ascii?Q?kO+xzyEglaiVNuaiLo3IiEig4F08OvlSgBa596PaYKxToxhqEcFrFHdKfQNA?=
 =?us-ascii?Q?kMTZrCug9d/wvXN6pI344T1TLXR2FK27Lr2om6F0RSeLbI8AGt5+hFjqth0b?=
 =?us-ascii?Q?w6oBryuTNEQSD2OGq8KvC/AU3tqyq8yuYRqSpOeFCfN2VoURF4pLs7Y5oIgQ?=
 =?us-ascii?Q?TwE19n9veBV/zfg2VkIc9bJWo5xNzMZAPlNrz9npEudblr4aYXYiXPesYvSi?=
 =?us-ascii?Q?j3aavqsdQGxoPrw+jHNbfyQevaJyWopUMs2KLIncenNmvjrDyAbuZn4fyGJX?=
 =?us-ascii?Q?rEI+VxffuDdrT4QzJvokjfO2toUEZh51AA4wQ8GRXlmea2ysfFso3TUJiuv3?=
 =?us-ascii?Q?EztyvKkWyHTDdzrY1BVQPI2CWLFOSf5s23hJ7YzJD8I1dXxXYao7LJjsRBH/?=
 =?us-ascii?Q?ZTUgrDjbvnlntkjIxi+0RFnd6bVYqOc4+ENa57oYiVrsDHlomSXXq87/rxQY?=
 =?us-ascii?Q?rtFXKhIROtaXNtNFPazEULTjxzoaTMi2VcJddPF4VLTiiC+qWHPlFKj0n63B?=
 =?us-ascii?Q?sTmV7Uj2JRvviRdzwwafcMSDYJ5g63QYhAdtNTMERbSMt8gcv0kwFw8Xa5yQ?=
 =?us-ascii?Q?dthVLkjvqlQg+tCJHSaAjPLUkWlX3Pl5pIyuKB6XLFAKkP2I3NbLxGC/Xs0V?=
 =?us-ascii?Q?zwZadjxvUYWMGUwv9veR4FUtey3B9qPEmJrpV9TUbIEH/W9pGVMuV5HrZq2k?=
 =?us-ascii?Q?bY370vaEGvbOwaPSKyMB0UpVuusre8cvn1jYEAlIyJZH3gcL0/NqiR/2TVDo?=
 =?us-ascii?Q?avE2evuS13i5dbH3+j89tx++735CkDt9CAqRxC/HqX2EmaLaXJCmhRpXDvec?=
 =?us-ascii?Q?E0QrtejPUIcP9rW0bMndp+NHxAQbr0Qsw/GVEzGu70K/qWZ1VbeVHQgkhIXe?=
 =?us-ascii?Q?G+U2sujE+435IZiRUfCAFT4hdFztQxCzOlEF3mzKx+yiK5f+OkMbEDNvYTyR?=
 =?us-ascii?Q?STxdFZwlB6ll38SJF0oLoGazjgxRbUH8y+W578fYq5dpEpXB9jw18Q3dA28o?=
 =?us-ascii?Q?dvC3o5XThxcWwIz3Nkz+XcnkGEGQ=3D?=
X-Microsoft-Antispam-Message-Info: mm3QT3DXfHGyqZ3nS1uT+mASx4O2O9Kua5YnaxCita4TFhLIx5BS4R3dvgq+289JC2ITywh29cMNhs7U7rn+/kJs4LetObTyw3lilSRWg6b6Kw9CieGuXWgvfufIskCasAXlUoCFvAx79MUqTX9OHq3x7/frSphBDiSo0KqnCdUgsiBjuBNdcHLyJvfiBkI14D908rvmc6Zf7XsjUi/0fQV63fFo6ijBFMksodgj1tXZcB1ayJ2iU1BhGoFDzHTecMFTK2PRF665cfgLRUqwP97WzhqoPbpp3ddHNVY6uIV6hxj3hMEbkixlMmTECKLR0PG9NNZs0zbrZOnLOfox6bV6bvAv5duCNTtw2bD1KCs=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0701MB1005;6:W6y29hgPrQy4wSf9fyq9Gj0XDWufTWXwQ4G17ra+QmbDTa55atILaFFUn0lEtv0qA7PY7WiMyPegCyJHKhdkdQC8v7bDdBHeNlxVmhagn//tZmvmKPbbqY/hB0DnZHt8qGJeXIU7VwA9ltylb2nQxK8G3RKBi3JNVhhInOnbdjWeeFrvKZaRv1qhLvtk1HslS2KkIlW2XkhalLYpSXwqTHm8H6vVMoRFoPOl/SLrI/JpO+5MNPWCL9ByDdmNEHs+jehhzPdaAWYIuvCIePGX3EBDMDkCISyTdZR9xGJW5KnpJJHGi7fU1VesswEuIj1tKXNZ2VaEH34hb12xVMFRmMitgdq+YIOWUs5jmWApDdbL2Rm1BhniYla/40Uxgm4GGDsdlqCq1GBXkvZYSlBq+6swNi5xteS8Ks47tp1coCsaDufbZ3cyP2zofG+8uVQRjYpqdZkPfpGlxy9icQirxw==;5:e9IufJi+eLOX/Yr6HIbRH5DwNVBqz+P6GqIiKZL7YCORkFUW2R/IhIwVwv2Y/IHOUPRDs1SeMhV0nOXrsHeSXKAP53IjGnTKhGC7rapSN0yP765rZB3krMarA+plpyXSHWWpyU1p2ODTrZwL1gB/owo1eJtXTUqtfDsduIhBYyw=;7:TdREwpqOH9ToeEApQEgnDe2a70iYMzBtG2QHFhhaPqUOvRADu32ywW5s6pvNtpr5dytouSKycAcjDCEu/7UcaxML9rvizRZiTkEHkZUvKHgsylEeI86+qcQ5+op0G9BQD5aZGRHX2jgUF0SPrqZi11VV3d1a4Uo0gYbBtWzfDbClUax0C2vGqhRXujSX9l1Ps0kB2kZLlFoxlWqjcv95qj9LEm/jYdnOEaYURLNHYoNv12v7GOcHVvFDL8BchTMB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 09:52:37.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f11fff4-4b4d-4e75-cb94-08d61d4c77cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0701MB1005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.18 09:38:05, Will Deacon wrote:
> On Mon, Sep 17, 2018 at 07:22:07PM +0200, Robert Richter wrote:
> > On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> > > Hard-coded since patches are merged and there are no configuration
> > > options.
> >
> > Could you add a list of upstream patches to the description that are
> > required to solve this? This would be a strict definition for the
> > mitigation being enabled and makes it easier to check if backports are
> > affected or not. A build-time check would be ideal (e.g. checking for
> > certain macros).
> 
> Hmm, I don't grok what you're proposing here. Why do we need a build-time
> check (and to check what?)

My concern is, that for kernel backports (esp. distro kernels) there
could be various interpretations of what "Mitigation: __user pointer
sanitization" means. So a list of upstream patches that need to be
backported in addition to this patch as a requirement would be good to
agree on. That should be documented in the patch description.

If these mitigations are available in a kernel backport, that could be
even checked at build time. E.g. we could have a sanity check if the
macro array_index_nospec() is defined. But such a check does not
replace a code review of a kernel backport.

I hope that makes sense?

-Robert
