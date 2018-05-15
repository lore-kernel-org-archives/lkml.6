Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3096842-1526411596-2-260587671589130269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526411595; b=iKYBUDNdp5mc6xzvdIVCuGX/WpHNrWNVOQEyyENjxoiQA/EelG
    qg3OqW8lrVYVURdhu6UraGGmVzBcNu236P44bUDTt3JRU/DaOaY5nEnokPu4WNwX
    HGKvQleVtUx+u1DyHWL/ASi8c0yL2YpeNegyk5pdpcrCcBr4NUULKBrqjUpgaB2n
    oXIWZqZM8y+cTI9myM9aq5KNHHZIo/cDTarYRV0eaYYtelOtMbHlHRfBn0laRk1b
    Mrsq6OXVd+yjrGQUyOyX0z/3YaCCIvF2YkNEiLGxnmw+Yvkw3ENN2btbdOBx72Uv
    dXo15/L0oNWziu1A3jnV7gLw7onvM/rbhP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526411595; bh=QHVbb6CZowYDyfbf4P0S4x9EEyogUF
    CxlqrWnQPSJ+g=; b=HqISZQuSmdP/IKAphhvrlhakdnrOF7TM/H1LfbQqcz1uae
    kVLYVRNDKaoLgFGa/Eqdy/lZAtsMua1DZvyVFOWHlwNPC1t5+LU40CV0JDhC30ul
    aUuTyy1t9Az6/Zeor/h1p1fIxvW60jwKzXF2KOJIW+Kdo4YUO5G7MfwOwU6EchD8
    7wIQfyS6kZc/w8n0Rk2kMj0Fduio1kIV9qCVe94aXNHKWcxjEZBEzFgDD1xURZP7
    wWcyhndxnn0hOS32K/xyAyZycvqcDjDof/J1/fxE8pH9h/crgyxYLp/OzLblHWhf
    8edmsCNEesIIgnsamiAoyCzQQjQSRYYI+sPPVRdg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=QOvClRbs x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=caviumnetworks.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=QOvClRbs x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=caviumnetworks.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBMXPDbUUA5evbqqkWtnzNBBfXeNPGbthv78Kdd5ns/usxbodRZiSx//GrCJMbWGtJnsBCXis+8fpV09brFtCyICS7BuaSrTGBce39cSn2VdNXnbqMNP
    VR9drxHoeya4Zr74Qt0DKIOTfsY7bqiduaWrOzy6VjooUvD0C2gU1bhZc+VXIJOQUyfXKfvqxKrQKBK9FHUIaPK09VIR7mdLxHO4kpcCgg5QnVdpn/C6Cfuz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=NMmGLDPa_bsA:10 a=mu3WYqzaZi4A:10 a=Do-GKD8o6ikA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=7CQSdrXTAAAA:8 a=6rqHouBjAAAA:8 a=i0EeH86SAAAA:8
    a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=yBqWpnd-oM1zklYVj-wA:9 a=x8gzFH9gYPwA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Hx1yvPaMooE3kwe23bt7:22 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeEOTNO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:13:14 -0400
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:12448
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752500AbeEOTNL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 15 May 2018 15:13:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        Adam Borowski <kilobyte@angband.pl>,
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
        Zhou Chengming <zhouchengming1@huawei.com>,
        Andrey Vagin <avagin@openvz.org>
Subject: [PATCH 02/24] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Date: Tue, 15 May 2018 22:11:52 +0300
Message-Id: <20180515191214.5045-3-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515191214.5045-1-ynorov@caviumnetworks.com>
References: <20180515191214.5045-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.40.107]
X-ClientProxiedBy: HE1PR0301CA0013.eurprd03.prod.outlook.com
 (2603:10a6:3:76::23) To SN6PR07MB4382.namprd07.prod.outlook.com
 (2603:10b6:805:58::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4382;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;3:p5WU0iYBjGAJcBiVxFUOOf4eDTye6HVXFjQcS6B3j+2wA8FMO4M7cLndhwf5vY4IJjls7r9LzVq4patHeYpuXVDKbWveLYg5PaOXdghS1l5+/6s9m3rVNMgV7qjVo0nf+61qJ11Rlhli2QHDp85sRbRqkMpmUYUO0Ez3a02TmSRCKAjChbiqjZbygThHIZtf5/KqTncdkK3Rr6kN+SID/F44kh9l5Xnj+kahFy5hkp5u3GCI1aVtx5ndVMAHMTVd;25:9udHVZS12KmKAwITnRACsR5pYPug8w0QYPSWEuB2gS5IhYqeDvKoGf0I2eS7IjKa2tjzRv/qVtT7AfxsdOSyQRVt94SvwvEnheuWMNqBQ/uiz9r3o8BWUpCUq8hZnLv3koDShf9H6ZTKBCVPhv8dsxxWxzmc6DqpZRWKhsrYZQLcdaU07Jpei/uwdeqbIJTA2WjsEoXVZk+WGh1xYw2tqVtZw0lf/QlqrWHUx4zsqUe60XgWXJP8AWBcbUQyN99cp8AuAoUscs39+tspQIO7yowkbsM7752+/Uibz259GYyxAdMwxRo6Cy/rlNO/FtvOmMqhRhqwg3s+pq1CwTO4JQ==;31:HJi+QIxlPciaxB5QPjWflXzjCb7H1R9d50fzGUsajpimV1G7gHFZuLTJcFynsqJMC8NFgOCjtUMqp5DN9GPk4wgOxqX0qu7BEvQ628DtZwTGN3VtdLWRYo9ycaLH+qVYT3hCW5/KzbL6kX9Mf9LHEfDiuey0kwrYWz8j3SxWUnHYYw2+6lw70nVMbGmKtFDXxjlzO8yq71umwx1zUgJFcU/5sDD0g6YYNgtSLU/m5To=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4382:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;20:215Jw14wRy+hM3CCrlkjWBMCrxmA2nsYglOhRRbmy8yWMsA0PnnCSY3ClYDUmbNzHq3f7StJIE/5p538MYxJ/2e/OHQW/8pplqVg5TaBcD/WSvYyimclMSHBKDe2++bF26t1V3DJKyyZBbD8Qrz28so6TEpLHfWzLUhokjYxwSdKbQgqptQYlwluZzA59xyKrycmTIb+8W00GwmafJauc3cpwB9LDLN/uXzku/1dCGfnfkjdBHGesl18tJyb+5gpniARdWc2KAQKEdHPCKDzS0Nbq6sCgPVVl9XBgumyxZUoEUh7KL4MIFMZowFDXav0gXyM7VGcb59nHBckVxR16zyPN1yOKIypoMx/XAr+2k8XOQh5FxwBUQMwL5JlaRAIMXlBZGCsJQs6KFKnq1UU+rLVBf0zH3LU0v2etsEk7X7uasThoW0T77iH61fF7FGNUyfh+cC6faLcyrpaMqIO9LPovqpxyNv4aVTGz3aVOFVRBtfjCbQ5bIXCF3t5KK41/HPnXiRJrtUuPq3q+8Lgv2LvVX2StmgqxO+YxyB36w+mvnr1+XpyhjcGo77aDtyfRnPGu9dEcctE6BminUlddneMAtzwe/7/Nym+VDXANOI=
X-Microsoft-Antispam-PRVS: <SN6PR07MB43820C566B8745F0CA07E96CE3930@SN6PR07MB4382.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(50582790962513)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4382;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4382;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;4:xV30ieoZhuBubCsxITLWKQDEPotAcHU9RC0gHYDk0E7xKQjNLZmmMh0msIdK0zolmz0RuHmSvYpN0y56k3Yr8DFPgJGr9xamawZmJqzB33LWT97GkNkkQWOkiL3wtU2A850I4wpk6d8DpywZxCsSjlfPUnjBSX6BYhN2fwc7D8VLfngI0YRDg0BiDZqMAcZ8w1yBU5joEJnbaj2xSzHjftznbcg7ke8IfwulQTUXavbxT3PryFCFSfPYOCRHu1Er87dd90YFqQbaAK42VFbKZYhtPJhMYOFhVHuNTzebm7cBJrkBOFdyQuMpSUwA4R0XLRMcgUon98dROY80pfIrL3Qj+4y15IVYr0PxDFZdSjJq9Om0UptGpouzTUzGs/Bf
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(376002)(39850400004)(346002)(366004)(189003)(199004)(97736004)(476003)(6496006)(486006)(42882007)(50466002)(7406005)(53936002)(7416002)(3846002)(6116002)(26005)(1076002)(956004)(2616005)(6666003)(11346002)(66066001)(446003)(47776003)(48376002)(4326008)(39060400002)(76506005)(2906002)(68736007)(51416003)(54906003)(305945005)(50226002)(110136005)(16586007)(105586002)(7736002)(478600001)(72206003)(106356001)(52116002)(5660300001)(186003)(16526019)(6486002)(25786009)(36756003)(8936002)(81156014)(81166006)(8676002)(59450400001)(316002)(386003)(76176011)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4382;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4382;23:586exUqqGPlQQXRV38ogAet9jZ66w0aCbaGhpaLQa?=
 =?us-ascii?Q?1xSMI9+PYl9Zh9XkD3wPn3AP0bleQrx8qBd9YSgYZeyk1a3oJL1baR78oq2i?=
 =?us-ascii?Q?sFt9HjaBDk2fZuaqFIDF3r9S5smIo+bccDjRzCTV3Uhu8lxfKCEcjBGx/B0v?=
 =?us-ascii?Q?DpsTaamnLc9rF0LWrdqKM3tZeYFynfsXbvmahOtgINCxj9xa6h0kmZgWLf//?=
 =?us-ascii?Q?fn1Vkg5klKca7TmjHZbXgpU6LTbiRgmeDDbObj9W+z/gV3TUjKNq01itH4Zx?=
 =?us-ascii?Q?7wHuXimD6qbCKXdBr5WfLSGCx9xixLi3JhixGs6HwI1Hlm+bYEQciuVjoCXq?=
 =?us-ascii?Q?4QXGEcA0fZCmXPkIdfdUaYUzMHFwKK7IUNeXYlklLbugkBG/qnjzWU4DkYVk?=
 =?us-ascii?Q?ssHP8WPsyLtRNmVtcPD/dV9d9se/WVWF+ww9if+puFASr9+ZFwe+7HfroyIu?=
 =?us-ascii?Q?MZG+CRbzxaLlkXQj90INHLQsaXbi1Z+HwFXmfkWpWATp6SJg5QUj9FAHU1T9?=
 =?us-ascii?Q?cDr4dIv1DQGyxTM/UkqOg7T3qzQzEzoSnaImSTsGoGM93X4oh9PMPFTmuMsf?=
 =?us-ascii?Q?xln5jtG4YsmDBG8lDGliqeyJKmTP3Z0ySQBqTFhUmI5fuq0nLuRdmf3dMoFs?=
 =?us-ascii?Q?Za4fpU/0oKX0fCec5zPDkRLVyg5b07so9kOR9YbtgYuvwHgdDHk8F4zYUvu/?=
 =?us-ascii?Q?I/0ahMDRUwu9s8Z4+B7WthOKfKHLsSlBDVpwIaA3XL7BwAtL6/45q0ag+ejs?=
 =?us-ascii?Q?J3rFs1/zhPCd0MFKaPKYi2UC1BgDge5whD+qNgrBCaW8wIgs4Wcezphau3r4?=
 =?us-ascii?Q?e+tT7Ny45MMZu/53v3l7ayF+yP9od7uW3H3WVMMhhxJsrDaE10NY+b1KgsTH?=
 =?us-ascii?Q?anE5VtQNg6CENtpe5i5ATN2IeoVcZRHq1ViKwrVlnK3WfzOSPQkCHS3ziMlR?=
 =?us-ascii?Q?2wziddUJXnnHwTQ2EH3xE3HSDwU/BgJfBSP42YlijBVxwwziXbuKQwOCwRZ4?=
 =?us-ascii?Q?ZaAlygek250I6sXsPekDLoSTWyQ4QJMi2WcUkhDzZJlOC1I6YiF5Amr66FWY?=
 =?us-ascii?Q?Hpeppsnt6GSAPy5hFsEmJWCl0Kd8U/poiZgusneqSx6n2dRFqD8tNq7UrFHW?=
 =?us-ascii?Q?Z6yzFrCJVXgU3zdtAuEO3LH95+Gt1C1tuQU+UFSQNN88D1P2hu23RfnX4Hu3?=
 =?us-ascii?Q?AM+C+drKXoT27YNOa+vghOgMe39nZHvoTzzICs2zQrmFQm5ZxsPKbKCGrzjr?=
 =?us-ascii?Q?aa3Ptha1LXxgdSfm/z74Ss1NMEl4DREsgqnY75lg9fXFEp2VTnxoGpY2p+vu?=
 =?us-ascii?Q?Pr5gGB9cmW6f5PpjiEqJsWmMqN+PVBH/T6SSEal7CDVryAy6xWLcFWYgR3p6?=
 =?us-ascii?Q?hPPd/rDDR3DS7Plai14FpxhSTA=3D?=
X-Microsoft-Antispam-Message-Info: 83glCjh+Hdx8VpGVAEgi0IMYmt/7rD5N2WI1521ceiLj3/CdIhlc1j51yronEEisP1glTpVQ/dkqKTQTRdpZyfMo4l9qv1pOU4WYtfnFXGmZUrQm67pTzd/NXh6zW02wPcVVWhGEFPPqySbEOBvMhZGKigVG3yCBG7p49kZ+PegFVwszFQnPP2k28wpqpPhE
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;6:MYjWK3v224mFc2xMHmQnce4QVaOueJdiIMOwbpgTF9GzhmPOevUqK9sX8B9z54WF/2Clfd94WEbGkdb9Fd9OtCIqqGYiL1Df5pkZwNq+Pv5H6isYqg02H+wmseD3nCVX67KIQ6VqlaorxhDd6gcVeee1Nwk47NWv3MNdkgyk0oC1gwm6ODXWySl70HyD0OQSLwf1gPE5Te7vYAM61eyhWbMTNebwWXWDvkSGsPyE6QAOQApBNG/8sEkbvTQuJn6udQo2LHFwZ4Z7lYPNL80zfaWvEO9PbsPn3mlpLzLZ5GpUNGAyfUwj4E3vhwDuHrCrz6Eu+yoOgrWEaCesHF6lXE/F4OmGNX6h5g9/x+acVN62l64AKo93Pr69jOJTKgXPDTugd/HUr1WC3+XldlsjHqx21+a9R5PwN7t0/ghrltKuRaaSWuzpz7KEiAh/6HnUw4VuQEyU31M4q0ie7ItsnA==;5:ytqIJrzI7X24Mc74qHanOTltfpfCkn2ICC1DuRhoktHJ9LzelxfiTWX4iTH4uo40Xzu94J1XMTkoi8nQBBorvxOu9I+y7gWSiXOVHQ7XibgrPEW8Q3PLKXSJLLV+/jrB2XjRs/usjkTjPvNxFfgiIgYxTJYr9bEtM2YLRQTxj6E=;24:zwOIV1fcXXJjKSdPnmddQMLFualwdg5cqBAzrciT7arfnsedAa4IDAMCI/cfN14C5cO81AT0bY2mq6++qVM+tUqm8TLqHOuqbvC7kJBnxVY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;7:EpzlGLa6mYskLqedSKGdz6XSPb7Dy9iPYWzCzhjXrAy/ssE0+pWMHhkeL8WjFaPZst6GZBop+xac7xFlgQtgqtp1sss+lFOKf2FZ4116l7jxNSqriAIAvckhVWYZaPnGYbZkp0iX0HxGkDlFAFbCuANnnHEiR2O5xAYBtsFNUGxSp8jMQwrxnNVRY3AaIw6f4UN6ezE8YroNfSHc2VqaaqE82wznQWrD9zslGbWmscOyQB3YVZtZ8SKen7dk8jvH
X-MS-Office365-Filtering-Correlation-Id: a754a454-dd22-4c66-9360-08d5ba97e438
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 19:13:06.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a754a454-dd22-4c66-9360-08d5ba97e438
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4382
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
instead using those in ptrace_request(). The compat variant should
read a compat_sigset_t from userspace instead of ptrace_request()s
sigset_t.

While compat_sigset_t is the same size as sigset_t, it is defined as
2xu32, instead of a single u64. On a big-endian CPU this means that
compat_sigset_t is passed to user-space using middle-endianness,
where the least-significant u32 is written most significant byte
first.

If ptrace_request()s code is used userspace will read the most
significant u32 where it expected the least significant.

Instead of duplicating ptrace_request()s code as a special case in
the arch code, handle it here.

Fixes: 29000caecbe87 ("ptrace: add ability to get/set signal-blocked mask")
CC: Andrey Vagin <avagin@openvz.org>
Reported-by: Zhou Chengming <zhouchengming1@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>

Yury:
Replace sigset_{to,from}_compat() with new {get,put}_compat_sigset()
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/ptrace.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..214944d7c268 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -880,6 +880,22 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+static int ptrace_setsigmask(struct task_struct *child, sigset_t *new_set)
+{
+	sigdelsetmask(new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+	/*
+	 * Every thread does recalc_sigpending() after resume, so
+	 * retarget_shared_pending() and recalc_sigpending() are not
+	 * called here.
+	 */
+	spin_lock_irq(&child->sighand->siglock);
+	child->blocked = *new_set;
+	spin_unlock_irq(&child->sighand->siglock);
+
+	return 0;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -951,18 +967,7 @@ int ptrace_request(struct task_struct *child, long request,
 			break;
 		}
 
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
-
-		/*
-		 * Every thread does recalc_sigpending() after resume, so
-		 * retarget_shared_pending() and recalc_sigpending() are not
-		 * called here.
-		 */
-		spin_lock_irq(&child->sighand->siglock);
-		child->blocked = new_set;
-		spin_unlock_irq(&child->sighand->siglock);
-
-		ret = 0;
+		ret = ptrace_setsigmask(child, &new_set);
 		break;
 	}
 
@@ -1181,6 +1186,7 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 {
 	compat_ulong_t __user *datap = compat_ptr(data);
 	compat_ulong_t word;
+	sigset_t new_set;
 	siginfo_t siginfo;
 	int ret;
 
@@ -1221,6 +1227,24 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		else
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
+	case PTRACE_GETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		ret = put_compat_sigset((compat_sigset_t __user *) datap,
+				&child->blocked, sizeof(compat_sigset_t));
+		break;
+	case PTRACE_SETSIGMASK:
+		if (addr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		ret = get_compat_sigset(&new_set,
+				(compat_sigset_t __user *) datap);
+		if (ret)
+			break;
+
+		ret = ptrace_setsigmask(child, &new_set);
+		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
 	case PTRACE_SETREGSET:
-- 
2.17.0

