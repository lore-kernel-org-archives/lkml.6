Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05125C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D48F20883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="InN6DQvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D48F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeGXSsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:48:10 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:14080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388409AbeGXSsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7FEbL06rEt/ZAe5fHDzcc+IqGtGh2XqwmssZDmvM30=;
 b=InN6DQvJs+ehqRsIN1KXWs6kM6CMwF9TkxeWv2L8ruOJm6aJi9FyDCpAKnfzslrtPtmCZDPeI+UKhD94KQTqAlVQtILhQTI8a+wu5Qaly32NrTqPZzciOl52m852+YNJcFbF7GAD6ypLzV2kAg/0xXfoc0O6gv3Pw/ArPVggKsI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.155) by
 BN7PR07MB4370.namprd07.prod.outlook.com (2603:10b6:406:b5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 17:40:20 +0000
Date:   Tue, 24 Jul 2018 20:39:57 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wookey <wookey@wookware.org>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20180724173957.GA22106@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: HE1PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:7:29::28) To BN7PR07MB4370.namprd07.prod.outlook.com
 (2603:10b6:406:b5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a29df71-684d-42e7-d5cf-08d5f18c8a8f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;3:BX0r6nWi3aSGQTvTTa8cLQgStqTM7RISbs7+8+9UR3oRkIZ9ixyXWadk/PXVLhXZY1wveUPEkHF6gsbbPRrx0aeD8DfcuE2pTmkJPTlKCULcVZjmW3j3IfojzjQLhEm7JF2UgXa4xciiPkRJf8k81Zr0tOC/zH7oeJt++GD/XhqzVv8Thtp628AeNwfAtHw3hMn8WwN2JfMJVFMkjJcybsi93aWrZlaaTgAfuOT2NQvN3YMWkUEaUmyUlFD53v7L;25:cBz/nNxztSZSa1QDulsCCcua56HHvdrizpSxK064mpx7eyprpzbL62AiDUUlf6ydVKiSGdXSZcN7ay8eZzI4VnuycVSypNuHJNk3Ra1bAv0xlTlenmg/YiLHgTcxsSu2D1RAKGcfbvK2eAzOmU9rFSW92HE9MWCHDaSbrw5R5VRYAofHvO1kUDlacrJrFx4Vm+vo8os5wVwiyIQ5QcJTIqbbn9gas8//PXiFnGngiN1iFS3su0eI+5z5s6NDegjngA5DYfhO0NEP/ZxxCbcHvcxS/Dik0xIu441LzlBuJaOx2JGzc467+cSFdrO1u+RTF1z0sub06sqn0KAVL16F7w==;31:ACTAmlqeNyE6rSTxJSBx18WLS8QymVgDujSz3Vy6+5iUIl3zWeRpuprutXG4Zasy978S8yfIk9llhQvnseVAGyFwF/cOJMKiLQi4bP5Gap6ZMe08K6bB2bXBfQZu2WfS2kPwOWPZACJdxqb0rzHqgc2bAXGkwjOnHHi0LR71iY5Cwr5d2Ld06oENSGQhW7l4AqXJHjcoCIv5wKrK8trK9O87okcJSXavbpol1E6xvQ4=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4370:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;20:Cl6/wDqletByHH7meO1mNCkY69wVGCRdYPzWIpuL8Yh1RufqRztVkcU7IYMd3wLEQW+MEIH7f8+uNYyZwTPcC8782tvwkGH9BKUzafdQCvn5J0xQp7vJXdGaReBTtUKPlws2E3f1neturcm35WTDNqlSx1eweRVmmktgg9HUtFTWk9ACLL3l77zloVb6E5qkyY+uJNycEegrZqdL1pyl19NsWU1ytJbkgcmGykWLUxR3ZQeF1Ij3/dahadeXtFhG/TutEBaXfKnb/pzh7bjKcG3TTb6kXZ09vTC7VyK4R7uyvSfdt8DTlPJ45U455CMsGoUmV7u7WVVKmTxsmhC3UTogNML4NnIy2GRxkUh/6sWYDApDPaZXe5K0FXrnSdYvUJCug+5TxFxdZ3KjvAySIMcYSRZfynwjg1mIO83flpfhhTLtAQYZaNPRo5KGd1wm5S/9Mo9nK2lVifMFJnWmP7g7WQa5dTpRW7Jrs5jElTiMOuH0FloQ2YALjahY9ST+VR7zrrzoiyr293/fsrv3P9w1XxGDgW0tuR58iTC6aXnYAObDVvDj2k4rWIsH54uPyUlAtIyH8jFNU7c1C7lQh6NguK2WjtMDCzNRGh3t6MM=;4:x7iWRTfb064qEC2Cb1o4VBeQhQY5fbYH8xemtxeQnIYrCNnfHOj6OPR+qv92qsDQ9XATdEmNeTHnP34FpyCB42rcf1PNaFZ2tMWiI+SdXSq78wrpgbX2pmjZRWG91GkIFOYRj8j5LVGI/5vSKPJsa2PyiGiBrMUlUpArQhf/woMQ0ed2qmlJ2LCWmFIt5Vs10Jj7Pjf46nqrrLVwi/E6EzF6Z+5R+/dfB784zF0zkPycr00kQVMZMqy0WU+aG8yGiY6yCSRTaauGaEbahl6A7xbakFvtKoSZEk5WFK2hbwhuaOe2aayzAykkJesWH9Kj
X-Microsoft-Antispam-PRVS: <BN7PR07MB437006FA03666F17EFF561AEE3550@BN7PR07MB4370.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4370;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4370;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(53754006)(189003)(199004)(478600001)(9686003)(14444005)(6666003)(316002)(6306002)(72206003)(97736004)(305945005)(33656002)(6486002)(7406005)(229853002)(23726003)(106356001)(25786009)(2906002)(5660300001)(7736002)(6246003)(66066001)(50466002)(47776003)(4326008)(8936002)(16526019)(53936002)(81156014)(186003)(81166006)(386003)(486006)(42882007)(76506005)(26005)(33716001)(39060400002)(8676002)(33896004)(476003)(68736007)(7416002)(16586007)(446003)(966005)(956004)(110136005)(52116002)(11346002)(105586002)(6496006)(76176011)(6116002)(54906003)(3846002)(58126008)(1076002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4370;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4370;23:7rHIAHc4o4d+C4UPKxhnVuUl0iQsCJlB9HU3yqkni?=
 =?us-ascii?Q?/xMiho1i5gTEzjT7NrLNb2c9Ay5A0OGLu7bllC5bgNXLaK6JuX2CPm23LHpO?=
 =?us-ascii?Q?zQCY9FzGwdJhNFNgaPjPLKFOKH/D9V9bzDrjMRUZZ7OnRLlBBIOlwd9vq/79?=
 =?us-ascii?Q?Esk57fE1UelB7vwFB1NuAa6wyEszEV2IUEK7xDhBkd2HoyxupU3i5AVZY8RM?=
 =?us-ascii?Q?aNBYswdkVEk+zR8oxR2RAIZcLPwrJzOeNVOk190wH82OrLW7x0fI2pCud80u?=
 =?us-ascii?Q?0Torj9U9r4N9JUSz5t600St3Kzcu6AoEPFQ+/syurs+PWdhnYqJiI3sYoobV?=
 =?us-ascii?Q?WYFwzM/U4c7k8anp0NsX9V2q1HUXqpj3ULkTMh+PyKL+7Qok6wZfr5c+Gnz9?=
 =?us-ascii?Q?+qK1XNFrBqhNE53m3/covmYWdz7JbsdFtv1/D1o79i6+CFf0qLHrDSlWLmal?=
 =?us-ascii?Q?riCtpiZICDddPT808BH+b2N+ALemTR9keVdyCQmuTtqdWpDVmTCH9hB7HSXL?=
 =?us-ascii?Q?/572Jq/QuBXhkZGNTgHmXp10Fjpy0PffLHlwtVtJE90aY6fXG7oyHD0iLOYW?=
 =?us-ascii?Q?HS7sFBNUsVI9GYSmAGADKP4MR6vOCMyAraY6LeifL/JYCSZ3baGilZiAACOy?=
 =?us-ascii?Q?L98tiWonf8cDNsGnCYC8GBTJp1tglzrQ72GDIkHN8UdfiAkzSlUxIUdtrtsP?=
 =?us-ascii?Q?r5FJpoYd8FarjlIss/fRevFESgS61mxEQWupeqSRq9Bj+JM+tCF8RvJZzeeK?=
 =?us-ascii?Q?RCLjokt2opmxVgTG8rVw46l1xhnNZFPoTSfX0FM/PtTlq2T35+UyESkObrdw?=
 =?us-ascii?Q?Mbkl4IC40cixxjLRHhv9G11j6aMyjGIc1+cP8VwvsDGxXIntcxjABsNfQw8S?=
 =?us-ascii?Q?Tgo/MhP+6oFYOCOJtpO7SCFfeYh2xS0oufLT8xPFCU8KEY/mZAgMeh2Jdf2Y?=
 =?us-ascii?Q?oJ/fJAG7ADHl2/lKMae/vMZ/0NlRi4qd0JYt2TIbtBFAn/8UNr4jCRp9JCSJ?=
 =?us-ascii?Q?1qhcF9bbSrRxM+Jalrjax2RO5fmi14EIzzxKvR3uY4khX9I1G4E1FZH8+ejo?=
 =?us-ascii?Q?1vm7wLYCCqiTUC/tPaqY1rWAiF643E7C+QrCj1p55iVWitE9F34acArLgzQG?=
 =?us-ascii?Q?oTX9TMmp+dt2Jscmww3cDArUkxxohI+pgGr8oXRfpsopFGRJA0NxZ5cZVYMx?=
 =?us-ascii?Q?iqIZs1GOglEzPkOMwZZTS3xSMAnt8ln6rnwgGkDEwDXlsqVTT2pyBC3wPryp?=
 =?us-ascii?Q?ASgQVy3xEnnvvBYa8LZW2+KS+Hn5D4ziUeAIBIkVlFbp/cWRn7rXY4iwgUPW?=
 =?us-ascii?Q?KYp7MGwaO/EKyFgdsfAKVkH6h0c6jAZauiWQHsQnmZqpgHPALUmnNeh+kI2F?=
 =?us-ascii?Q?PxNAAo2L214CwNAFMrD4rZqheTHClhJHrWs1vpK5DhrSkaf3+19StgT2BcFh?=
 =?us-ascii?Q?1L8Q6pXAs8nZmkpJPwHlsaTwz8cUmE4dtxbWy5SQm9Po/M54sr6T1ZWnwukI?=
 =?us-ascii?Q?JlA0rHsdyX0HntmEBGEa7jLPwVnGmtg/RI=3D?=
X-Microsoft-Antispam-Message-Info: W2oLT+wgSLoATHId3DwlGDs/MdR+S5U8ul51u/vPtrWGwHT8We8UNRpUMyr+59vccJoysp5/IVcLGN1MlqFU9lSjlp9EMQaKxlaA47Q/UpbF0iSM2RXzsN8VXShlLgfNBgaIHbx3497yUXlhL2c8zfcbmd+lgotszZ6Xw+Foq0vJMGQKUu943331oP8BTD22R7W3A6GqWhRJplFrwiet+IgD6Qeipd89z3ePFHqSWowxLD2b2lhSq9LK7gpomUmxz1F52GiBKimNiX7qZjrFVPTXz+/y9JbdmJP5S5i1WO7LoqhfLCiNeT8iI/42kg9B7WejBOmFBLTm/QXen6Gnj36+EeZ5dUMU8xGUsvJvnj4=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;6:vYqi5Rt+hbZbfxU3xDANzPrnspN1jtoAqXfki6Qe4rb/XQQdMnr0Xg0EvHV8ZB5FU005YQqf3k1hQu7XxbfOBgCgFY8nE1EMjG1+0nBAbkrhmtE5DeRlVuMSLUlOkPL2V4zo+/3MYgQMhzgv8cGx+L3v1PHc5ADvBZIvzJHM9wSZFY8KZcVjdAhorh59DWjPq1F19iJ1EynZuDG+IYdl4CMuC7mNPNmT5irrc1iCnqlOOdIqEWgkltXbs06m2IF16F/8T+2xB3NtBfJ/Y6p4gGMguXiTevquKDrh5Nz1OOnLZgYBUSJjsSja3pyUUOV1NrHGIiood30cgfkKma9dhe6YFuli0vgmn2w8N1cgSIVMzzvxN/m3iW1Lhcugg1IwcTjoqT6Mgx/wJLQlT9lXWDxd7GK8ubkA/u+eWwrGmIJs8m3IwYQfG4HklHLnBod5C7LDwd38GrQapdXdG10r9A==;5:c96v6AkFpa2pQEeCnOEJWyaROfIp9q0y1TCR65lAD241w4nhVxZxJNB/bcQDZoj5yc3v6Hi+XcHxNVz+qC/WDXNwpZwgTLvF0YPycWWGW+A71zIwi7LR6bVoRTsGrqIFLfpxnRrtZg0W3bN/bdn5BWLwT3kknXzHaUiLhw63AwY=;7:BiCtiv/2dMGyyF56uIOKMvV3Ja9scw0Hj3hHxvMmCYledRaqEbFHsTePW8hvZOSxL4B/1mUbb76+HP59B1oXyyejXPU5j5a8JdKNCIgdnluIhMhT+44SaJuAxsI05RjZdbgqjGkrQyYVeUtkSDKdWecp5mxXWVMwVzVsWrDEG1mNdKTnhihfOCqQyczybpGrTHC22id3SG/RFRgox9uQlpc5qo68EXfFwvGj2ccs90OUtGNTcUfL0SedOpA89Ktt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 17:40:20.1908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a29df71-684d-42e7-d5cf-08d5f18c8a8f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

+ Pavel Machek, Palmer Dabbelt, Wookey.

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is the update of the series based on 4.17 kernel
https://github.com/norov/linux/tree/ilp32-4.17
with the following non-critical changes:
 - documentation patch extended with few words about ILP32 in general, and
   the link to ARM document about it added;
 - nds32 and riscv32 exceptions added for ARCH_32BIT_OFF_T and
   {get,set}rlimit (patches 4 and 5).
 - changes to architectures that are unsupported anymore are dropped.
 - Chris Metcalf's ack for patch #3 removed, as it is related to
   tile32 which is unsupported now.

Reminder to Arnd. There's arch subseries acked by you but still
without progress. Could you consider taking it upstream?
[PATCH 03/24] compat ABI: use non-compat openat and open_by_handle_at variants
[PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
[PATCH 05/24] asm-generic: Drop getrlimit and setrlimit syscalls from default list

Yury
