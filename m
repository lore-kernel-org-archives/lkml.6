Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2820223-1519130388-2-10561575983024969576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519130387; b=h29WNxpAvfXFZzBe3yGnvonHNJ1mYp8YjapjpTg1nKPgcz2
    RM+3/YpbVpEFzr0MIVrHs5wXDVPteA3/A0SKe4b8s4qQ3Etg9GRJlTxs5iW/s+gT
    xg0lI7uQPY2dpN2/Inf/qOzPN+vIYGrC2FF6R7DaPG4gqafPaDM6oMQ6pUIf6SEQ
    ZOvdJCqAyrbt42fXMqXRx3QUcoSB0Be5MBaYVsYKYshRigAEcvr709d5jeVvUKRY
    fsi+8DGB0BHAjQdrcJsROui3w5+HCvVbdUe/9lpkPUTUI/kWMPWTCA1e4zHGbClR
    CnZn+4Nidd3wyRgWR69UExEXrC1h2SWC0WGdJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519130387; bh=s2skvgO4HTeCbQ5pvhLrsRSuOWtM6hMw2loBiIXAJ/k=; b=H
    jnC88zyTh7TdpcKk5C7m1x5V2cjif/63SzaJqB8kVPSE2zhOSTvyOR/QV0ySmHOp
    4qS+7+P27P86BYNeyHc2StKaRoWIK0vBBck+QE9CsbJNbMEewSOgJB8iK5/QMWTx
    ZCqCbWlY/DjD8E/jEllE/P4m3DuQmnrf/PhqXEt5ppmOQoRqGT+F0jqcrir8NCdR
    z8MdP6mMvtFtKwTjxctjJQfXm2QR+qYFfXeFc7Fq2Y8sgi4yhRRyHxZEyfbcRF4W
    fDSIeAEj8cOTXB0qE5cwTuyYmQ0F6CxF5m8+YjrHlbGNILBLsseJSLeobdR9GbOQ
    vydOc/SMVXG+82+56HSUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=s6UDksjD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=s6UDksjD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeBTMjo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:39:44 -0500
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:28497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751528AbeBTMjm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 07:39:42 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
 <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
 <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
 <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <aa9792b6-14c2-0bf9-712d-f537050ea9df@xilinx.com>
Date: Tue, 20 Feb 2018 13:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(77096007)(53546011)(59450400001)(966005)(186003)(26005)(336011)(478600001)(31696002)(229853002)(64126003)(31686004)(63266004)(23676004)(356003)(65826007)(54906003)(316002)(4326008)(2950100002)(106002)(110136005)(50466002)(36756003)(76176011)(86362001)(83506002)(2486003)(6666003)(58126008)(9786002)(5660300001)(6246003)(7416002)(65956001)(2906002)(106466001)(65806001)(305945005)(8936002)(81166006)(93886005)(81156014)(47776003)(6306002)(230700001)(8676002)(36386004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3379;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:PLA6bwN/TuPFNVRKAtMAQPlkGJ7js7BCnqeG9/hvsQmn9TExr3Rw4CyAicX/9p5FelaLoQbG8E8FWs3plK8qrAovMsgcW9cJUNjIyjAf3eA3Gz7Uqf4uR9UZcpC2eWfP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5a7778-9d16-45e1-5d5f-08d5785effdf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;3:y3u8e3Dx2lApZ9ZaDTqkIIqBXKeqtgDZCT66WjtCNlNMHgjYcoeQwd1W97/293IVj9azTEAgmtFwiU1vf0bMijouRv9mG6v1A1yWhcLpnHKs+bYyHi2z2S+XMg3T2S2D3biMzW6lnuYYWc9i3WdTgTX3tsxccbKi1GUBrDKpVmIIkj8w44CIS04fSTZxT4jCgTPmsPSoVfGcLs50QuABe5j5DuWQODi8MJXaPKxI5j72PudIqrvlOtmPl8rdBmqF4ZzXskH/FgKIKHuZw1aPAFdUIVwShq1i0j117oGmffgQrfwb8ayagpw4YUecL/oJze9QHpz074OIkDa8+KNmuw/lU7BhnxvpDRNRYDOSIHo=;25:sPEZq2JxWlz7otGXGAKDN1c/QmmfXEPK6lxiB51huIIL9nmEUufk6TB3tHRBKd2HhCzjANof7AIJVjHsWYSckcAnDzzZlOU+iNv/5Uz2XY1p0+XU1MokYUXBziiy36pzNpU3LLryJ09VEM6lwoeG/jBvWk4uUyEkEP9/WHwVsobwMJK6+Y4fG8C9p0XpQElqpId3Bplc97xA6/BGNg+XY6fv6K6xkF0yk8FaeqTZ/vZXTK+4BucM0eqdx4jB1Hs/FZuH797wiADpIMveC+CAubTVlQwjrIYPLAwl6BUF8nOWAwTyav9IklqAXClI22vfY3+QjXlW1kMfR1UmUK6K2w==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3379:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;31:JThCveNy+RKOR7fd40H4GFYRidagnymJGBHv3n9De1HPJgDuRQexNKKIlLyj+T2AEKPCeyGm5754WWBoNTMJCD23A2udRFLgqeVFISxqhXZ/N7rM5n3CU4swWqh9uXcCOs/zzxsyHKocGAJ9WZQuaEtZ4eF6LJbzVAYFLmKYmdTi5mRqo+v331IUV+CnMUobNRvTgMTg/LiEVqTzVFqQQK3c8pgY72PaKSkv4BDNvbw=;20:F0Yhunw9dtDfyw2Qaz8863ykj4eIQhHelnOjEtzZUwvVow2jyJdXjEwEvJk1g908ChUuS5xjPFK2Yunt+4X1Nc5zGCI/rKhsYSSa/3gWj9TINgchAK74YGrUiBv5Ftb+P3L9vbINGjvFtl6nkpOTck8kjl99JNKsXBqytkNYH9LWnlP4jJDlmcmS0LTMOJR0fvBdA9pBR+6aFUSAooOSd+Iqa3sUhiNSavGWt7D7/uZNwlcDbHXRTeK36LsY3e7QYQCXtwE3inVM3aG9yJU9/OAK4CLuhZW2cLH73mJ7ro2KDumGj+T4Gu5PTUpT2SoHd5VAfeZzatO2z7DOYqkEWZKe73pJDOCmZLoODzMScAjbrWSIsYBNbgSdcvz6YBkXJvgRZgNeQrptkHUhsLXqNq4zlB3Mp1sz6sBprwhQCrFDL2Emhu8mK0EgUTXDhptJJNAg97PSX+gyIIZ77qW1aBNRxTARKDEvdCVnnq/HaOlvYzYcCqg2yHWYvB3R2GuW
X-Microsoft-Antispam-PRVS: <BN6PR02MB33799FB7408BAA4338D736F4E2CF0@BN6PR02MB3379.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93004095)(10201501046)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB3379;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3379;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;4:oylIgG2fEPJbASPNS4xl5HTnteky4q9zk8wet2az2DhA4GuyYqfTiioLnglttGXG2QJ9F3uCFrZvR7Ejfmre1M2Pg91lrYKhwmBKsXb86IEJ4VdnPUSvhDn2rwoOhy3qNr7RZOOPNnWzTYWwrWzMWZbnTYfnVQql3snJMRFCniqy41UNDjMtmiPab+JLrQwzl5GWIZ5fr4nr3M83q+woiNBzTwdoclmv6bP9oNTPR/Ug2jgA9j11WWM0ZPXVwOXsbaKgeQI1a2d0zGwYs82kStr2ZipmvxoB//uEUPisr3PDd4CB+MjTXlZb5MrqmG/g
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAyTUIzMzc5OzIzOlUrR0UrZ0dYU25GTHh0QzVDZzBlVmxPSXZi?=
 =?utf-8?B?SGF4R3R6ZTRvZHFQMHJhTUFSL3VRcGNKaFdyekZZUkV0WFNwSkEvYXRlS2JF?=
 =?utf-8?B?UlBueDZXcXhZek1CWk1CK09TMzNHNFRYbUV4TStTTURDYXVSSldwa1dBbGJN?=
 =?utf-8?B?a094Z09HSSt3Z29sRXlIcWdic0E5YzFjRzBPb2M1VEdjZktMelo3RnlVbHh4?=
 =?utf-8?B?cHBKc3FxUFpBTFNGYVZCVGUrczdzV0V2V0c0NEJEVzczMEFQelU2WGFmTmhW?=
 =?utf-8?B?MUNxRkpscnp5UjlXZE9nWHpqbDBVMlAzRjRyZ21Yb3RlMDl1MXN1c1JyQ0lX?=
 =?utf-8?B?UHRVY2NlY0JxaWNVci9NZGlKOEZkN1QwTDZkd2VORm5EOXR6ZWdDVXdGVmM4?=
 =?utf-8?B?S3dkcGNQd3dtVkFPYnAvY1ZzRVFmOVNIR0tzRVpDSXdHTkc1NGlHWnFKTXFI?=
 =?utf-8?B?OWdPbTJQNFV6ZGdibGx5ZlVEL0lESWczN3QvbXlzVTVlRERRYmxZK1ZIczhP?=
 =?utf-8?B?M1BwdktLd1N1ZFI1Qk9yWmR1TzNNdmQxSlVFdHpjTnJJSS9CRHFKQTNScEZM?=
 =?utf-8?B?eWtyTDM1bzVwdHhlL0wrTFZhaElwQnljbE1uTlIrL0ZHZ04vVmdESFNhNGpU?=
 =?utf-8?B?aDNRanBmKzRYWGJxWnRRRVF4dE5yN1RNL3ZvSUZLYTMwaDhvVXVPUzhkQUlk?=
 =?utf-8?B?c0EwY2ZQaFNOWG1LWnlMbDJaTWZvQnVpbW1vajE4UXRuK2Jmb1l5OUM0bVBp?=
 =?utf-8?B?R0U0dk1lYnlQMkxRTTFFTUtIWTQ0NURhRW5ZNEM5cjRKNnFmK04yMVU4VHpw?=
 =?utf-8?B?TGRGUG5ML25DUFFQSHFWTHBRT2t5VnZiVFVUcm5PRVB3ZG9xTVpiNDF3eWVm?=
 =?utf-8?B?bDM5L1dxRW45aFFSWFM0R25sd3dEaFphN2NOalgxOWxKRkZTdGdKdmNLY3BY?=
 =?utf-8?B?Q0dJWkxyUnFESGhhOTRBODJtY0sveWdwSUs1U3kxdUNmcXo3OFJUN1lZMGdS?=
 =?utf-8?B?MjFzV05MVzBqeHp2Y2JlcUdSd2p5cU5BSEtqa2pWeElIV0NqenJoTmhwQnd6?=
 =?utf-8?B?UFJQNlpCNHJGaGdxRU9lL2dyRE1EdTBkTXhzRkN3OVR0YWFKbzlBZEJhaUJG?=
 =?utf-8?B?NHliY2VIRG85ZGRrQll2TmxscFdwYjRZWmRtQ0h1L1pGbXVJM3Y2MmpHUkcy?=
 =?utf-8?B?cythZ3YvT21DZDN5KzAyZ1lCdkMwc0QvZTg4M1VHRnFqYUxhN3oxQXVuTlpE?=
 =?utf-8?B?OFc1L0s2SGxtUXBkVDdhOGVQOC9ySUFOdk9kUFFCalAzWnd1Qk80aXVsUlV6?=
 =?utf-8?B?eFVKRDlNbW53WnRjMThDbVhNZXNLMkQzeFlYMWNlUHZ3MWxnbjdJcEJzazBh?=
 =?utf-8?B?OC9qRmZ3NzZHZWUvNFBwTXJHZ0I4V20wcWVGa2JINWt2MHBGOXBvKzd6S243?=
 =?utf-8?B?eE1xR08zU1JEUm5vZW1DZzI4UG15Wk1XLzlqeTNrSDdNSDBBYnNoV1BsZTNN?=
 =?utf-8?B?YmMyaWpUdGRBcTZ5NWpvVWpLVkRNZStZdGlCTTN2NXptMmo5bGRnSU94dkRr?=
 =?utf-8?B?eEtlaldlaWoycWlwNm51Z2YzV241OEdUYXVKeWoveXFWQXdOYjczTWRSWXNG?=
 =?utf-8?B?ZnhlY2FUT3l6R2cwOFlhWGJQdmplRS9yUEZkUUZlc0JjUEFpUEgxRSsrR1U4?=
 =?utf-8?B?WHVUU29EUWJoV0VTblgwcWEzclJlMC8ra0lGMjMyTU94aDNETmYyb3ZDTDVi?=
 =?utf-8?B?eFUwajNPMzRXeEFDcWZUclZjb1UxRjFUdmdGc1luT1RFeE5TRkwxWDI2aWJl?=
 =?utf-8?B?S296dXpXN2dDaExqOFN1bzFKMXZzdHFzM2xVSVVVMWpkVFE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3379;6:BipZldrSO9mLeI4m3cz6jbYQKy8lrPY3KqdJUK5dAd5Y9hYi0JV5xovv3kACxEUpDZ6neWKfsm+8oq+VQo7JGVgFhvAdXjbaDzgGFkisFIfVUGzhqQnINyoTC5kGei6nKItV8hdIW3a1YiqjAcL5/COmJ3qWkbsH4DaodiDb92DPuKFM2+fS0gv2AR1c0JxlwB8PBpV1GRDtnSC7nv3Ubts6BUG5O5luO7vHlMhACdGr5fjRyre6qnO3gKY1MKTRQ+q/1UdSyUXRARagDIXY1o8+Wl60FL/JD2isUQqrEKu/xCxb3JdRRJDJ0qiHXcx4dz6Xnb/whkY8eX2I2TamOK+3pCN7YaU4VScsCdlyH2M=;5:SocTL2K+eDusCcbuOxiX2r9jEgtLAlRdTjqR+Ilcd0lSfq1N/jZ0AK1IbIMLFObpUEqSvx0zRDueBfl/gP0wmiTYA9Smerz8V2pvzD9Yh4nV1Gg/vCeNuzlXG2jRY3XNPRzq9wdFltViJ+xxTqIqIdaN6swxzjR2Q6E0pyRvroE=;24:lsJAus9an7AKyCU75l8Y998IMiVAeVhO7fi3piywYtMEuEwHRmswq5WMekcxZHkCSDqROgF60IMKTiSuSHGu4jey/EWW7bQ6ilUr84mGYtU=;7:lp+cbzs3vIssvKk7xZGxU8U0AM4fLAObXc26lOg/hiHbQpVnwV6uwxfRXKkz+x0vi4hnfWb/6P8jkS0nHHj06a+JGn4RZWBRgKAWM6SI0lzuX0grbVzIBVJbrGp3F9bliKY3metW7iJPwibfbVbmlkwVHLCkyli0df2PrFD+tTr0wQ9VKe9i82QXJNt5gav6lrka2yM6UoneJH0zjsFoiukiQZso6jd/ZRvTme/Bg7OVkVTGSoJ3nbOHSMGCCqhS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 12:39:35.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5a7778-9d16-45e1-5d5f-08d5785effdf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3379
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.2.2018 13:27, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Tue, Feb 20, 2018 at 12:27 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 20.2.2018 11:38, Geert Uytterhoeven wrote:
>>> On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>>>>> The cdns_uart_port[] array is indexed using a value derived from the
>>>>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>>>>
>>>>> Fix this by adding a range check.
> 
>> I have checked 4 patches I have sent in past which didn't reach mainline
>> (probably because of RFC)
>> Take a look at
>> https://www.spinics.net/lists/linux-serial/msg27106.html
>>
>> I have removed cdns_uart_port array completely there.
> 
> Nice! I'd love to get rid of fixed arrays in serial...
> 
> However, IMHO it's still worthwhile to fix the out-of-bounds access first,
> as that fix can be backported to stable kernels easily.

I agree with you. Not a problem with your patch and for me it won't be
problem to rebase.

I would love to get rid of CDNS_UART_NR_PORTS but unfortunately this is
passed to core via .nr.

Thanks,
Michal


