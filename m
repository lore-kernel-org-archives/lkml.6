Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-788869-1524468831-2-3804030043144032720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524468831; b=GENhmrdk1VBkAG3aiMOoXveZaK8HIarCLxPTKfMUDu05lYAg8f
    /JkB24NSQZNL2nQPuilGlHDXkyDRDbzTGliO12mvVTviWkdHr+mD/3eAYj7I8SVz
    C8Qnk3UKva2SY9Us/a1QuyoAfOl0n9Pw8luCI/eCgW2fIu+AgP8VbzjHC2lrWsoh
    S88eNNmaiyHnXDOyaghlpcsXxpsd5r/2Ph6nO+b0ogNUL5Oib1e8RCi5sspfpZ3G
    GNFxfHu+fTg41YzHNJ0qON4C4tLOuhbaDGOia0oeEItjvv++t66+p/sdYSc/2nu6
    vTQRzZgkajjpnw/j61O7dEU7zIfCFxNDs8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524468831;
    bh=8o9N7WFXRWE4/tCydCn9y0NRawiciUNUS7OMl9dqInA=; b=b3apWf7UNbDB
    4GMkBK7ca7qMqaV4yIjr7+B/iiiR3jPhN81do7Dh5pc0NlPcxtGBJ4b7avVq8KWj
    bGWsyNazC84UFe5RFEr7bifUWyUjgDj3q8Anxh5zYSMsSnhO6AC4Pu1XSuYqN2Ni
    Qs5Tkdy2IypQd1rohItoD7Wud4Iplu5dhlyq50DNxuQds40JfcVn0NwDu2l+op1A
    iCXIhiW5tbMBeLt1NSwCJ4wFYj2TC7IxpcES7lA2lTyxPCoixtsqXP1r0BXMtOHN
    9/To8ovmMJxmG25kYmOAj34j+z7JAhJiM8iz3Jywuwq4PCfb18AOSUbICMya+cPk
    vzXKHRKRNw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=akTaidwm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=akTaidwm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDoDl0BJsvLz4UuYZTP/j4TeN2aCADVFVufCJvR5t5nJ3Om/7oIIleqZufnhELSjGtX+gC5mhil1U0FbemDRdSqwsBHwcweh2J8dFOW3LqxuTk2OIBFq
    VXMTD00Jm14lRp/vcaVgT9QsdTakF0hJnw/QidTBaoXdpYVyR89bNNvT5FkFTbOeExL/PNpMbrm0aUCtKwV9Tp1LDEDPjSDBl+kNwOk4qV2D6WIp8A196R80
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=32wYES3LoMUA:10 a=otyTMIrQUO0A:10 a=EFEsHzkWX8YA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=GxQisCVLOtIA:10 a=VwQbUJbxAAAA:8 a=ulgEmQYLzUsuQ-DwmhIA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeDWHdg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:33:36 -0400
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:26304
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754048AbeDWHdf (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 23 Apr 2018 03:33:35 -0400
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Date: Mon, 23 Apr 2018 15:33:10 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH resend] usb: chipidea: Don't select EXTCON
Message-ID: <20180423153310.47a20e6d@xhacker.debian>
In-Reply-To: <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
        <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
        <20180420170126.732e093b@xhacker.debian>
        <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:604:d::23) To MWHPR03MB2640.namprd03.prod.outlook.com
 (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:gslSgK64NhLTueWTQcMaMrIr8q1pF0IV3QwtlvdXLIieZf9aGtOHI1AudwdcftTj/m0Pv7dgKrsC6og+EwaLIZuELwhg+jHIV+4qcqBaLQltT+S9cfYjUMoRHRtRmiS6HNH5wgiuzuLry6NhpNyZat1P9tA759hIn7Otevx+wPy/kLJprMz1rWeEnfzCENEmQQXkOj9dDG/Rfm60uoxMxhXOTjeizol1OVR/Srcqw2wAMwZ+OF6PYegZ8OQqii9P;25:dUy+q+qLu9IdlVlWQCMWQfwEggi24iChI+0UHID1n50/d6KzWvJvOKysi6tMmMziwanab4djlW3ZfSMiRB3VhSIxMOaBC7p7m7qFtphiGfOWr0c+MZcTfQLPQDyMAjuGRjGNz+WusscAmoW6nJcRdX2foiDuIsyDfJkC7EFT1yoK0PAG6DxO/OtjRhZYzwF4/+LR0kGM5b5MvxHtyxuuIV8QsKL/wWhmdR9yIGCLsFbSVzxwq1dyLfPBPm1nUmK1rLilkB+SkRgnMfz5pEU66HUiZy4rWM74eCLKtC9bBFNqF2l03WXrOh55h6SK7cYST1GOXkOouwgVACJ1r20KSw==;31:VuGyMZqU/w31HJciQ48ho1JcUm+vfF8oXsx9UoqOZUMD/hvcur5pbaX/sptHDGdTuypM75pw9JhkzuqpsnsASnw/Jx4786zXsbHolKwEdACNyx+8OgJa7Ck/8asE6dAZFutjJ/uMh0C6berOvlHXoIjH1s0QBmypSHfllsqh2CcN+juFiUKI8thbVMDkJKil5DFvwnn0jTxtW4w0jbrsrOrYNTpVo8VeTpHRf03lBuI=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:QZ+u6baS0fUiuKWwMMDJ1e7p9mVF0+6cm41Q4fG9o9eEh4bQt/0bJb3O1+TA747+zAuVMtNlWoJx04SK7sPLPD1sXcCKOFlMTr4i/AwJRwmKW23bG9poKY8m1hPBemK3q/gHMzACBdIHmw9KkWol25CAU5vj4Kkm8fuR6tw8QXdGZ4RZSGcds6TRbDwmnC8DeRP0EfYPUz9vUeao1pyw4oOoMumlKC/uESX8AQrNMGjZY8i90SAmxCyFMfaJ9LyIvWqA2vyJofsd+OKRDe8d5dpaMes970dn5XUCaQx93dkCrxNnFn6rYThzvbO5dYEBHABGH36a2tPS8ERLduw0piv5pUvbdA/F+TES95wdguJIVVpJhovG7oVHrFhSJkf4lWPdWMkQhcR/3wKd2g0YoQ0Hs0XZX3Yfl7fSlgUGanwwU1xDuHja7huyQh6lZxcwZtegYhQyhpy1ZNPx5R2y7UAduBqjbX6mFC6nIw7t9xLoXYCpr98webRi0mY36VHL;4:JxuEWJ9y2My+9MNK56hVh409NS6kTmFhZ7+MQINl7t2OuGuR3lost9YV9mgQU6cke+eGbxEa8BxbOfMC1jb1iNjIqXTpLrQoj9RvpjE7f5g0gWqAeeD/4nRUWpFApXFVcQ5b4fdKECY7Yw7qSrOLTR5V6n9Vye4F1PrtL8mLmM9tX5lg2R6HOEVt5SDKv57+24m1DDw7Wd72vnox6o9nYJeF3oUJW9vnc29YzX5rFdChGulyj4ZWAmZuZMPaL6LSACtLF7nZc3AYMYEo3OaFnQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB26404D639E3869B0153ACF6DED890@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(39380400002)(346002)(366004)(376002)(396003)(8936002)(76176011)(7696005)(229853002)(6916009)(1076002)(53936002)(6246003)(8656006)(6506007)(386003)(81166006)(93886005)(86362001)(66066001)(11346002)(316002)(54906003)(956004)(47776003)(8676002)(59450400001)(52116002)(476003)(2906002)(446003)(50226002)(33896004)(305945005)(7736002)(5660300001)(72206003)(478600001)(25786009)(6666003)(16526019)(186003)(23726003)(4326008)(230700001)(26005)(6116002)(9686003)(55016002)(50466002)(3846002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:sI/V890Tohf/7Yf51ne5hrNys878CYs1N4q6XZeWC?=
 =?us-ascii?Q?tvwlG4Zso5rlDUpvnlt2wrXcfMcqPNPk9JWRynemSqH7gOGbPC3Vpsy9VMvo?=
 =?us-ascii?Q?D2uNuCpyOq0G2elZVPySLxUcpfM5ZJAONl7wDC38hTcoNnbQQtSukItzm4E6?=
 =?us-ascii?Q?hhiIWaaX9OF4/L7GefV1+rJedzT1Hlhoh1GoQFFP6+9ajlJZ3T6/t2I532df?=
 =?us-ascii?Q?nBLYczpspzJnVKZP8bzL1Y9x0QRXu2nnsky5OF/9RVgnirCO4hMXTw8gyM7Y?=
 =?us-ascii?Q?MPAM8hmUJQCF6DMHcIMyH0gVxpaO/DuoBYJEVeuAxlIDA2INry2E2K4WZU7O?=
 =?us-ascii?Q?0xkkvUjb1pDmoJL1c7t8nNyo/cRHPHg84jkj6ZmdSl5OISmDXsnlvXiMcGZJ?=
 =?us-ascii?Q?G3infb0ZlFiGHAUffxP2yRMhI7hSxIarSJUxk/qyyGKQqetSt3YPVYP1RtEF?=
 =?us-ascii?Q?36AQKjGKItAIs1jiPvpKjJCnXIcQYgT83RgPQajEmspA2A+TtASp8RHM2Y9i?=
 =?us-ascii?Q?zj13G8LGq0BEl4grZuI8OT4FM8ro3NdBKODW+b+I1XSi3OuaykddI5OHvxaH?=
 =?us-ascii?Q?kzY4RF9jqahQxtUd23wDv0oQWU+qzuaWZXaAzVa/PptYaEdLXyEw0zgEVFTv?=
 =?us-ascii?Q?ogYlMob8sMicVNSc4bAfwR05rVhE7io513jUcG3slSyZU6nhA8UmIHjziQEV?=
 =?us-ascii?Q?3hrsRu1tsOgm+dzwzDU8eTpOoXc1/WV2PsATTL1WLrDsYycrzkE//U1/KukB?=
 =?us-ascii?Q?2qRZGeGKjt0ZYbzMXJOx4N3MjyB4xR7F0U1NV5ZvqahAXxwO1qQMK2oCTzFz?=
 =?us-ascii?Q?TKDoMdtNdLnKanFOJo/sdfdWqp0S+UfNcijlZ+x7eynzotqPJlrQ2j57i/B+?=
 =?us-ascii?Q?JNp0r7nQOwIEcOqMb7H4MFrw+vRER5N2AR3f71Kvk0v1jy1yyAUo5kWOmwOT?=
 =?us-ascii?Q?ldsVX6NcuzDWNMlejQCvxyjKZdhHnyc7nbr0QCAe0LVqqoQRtKGe+cxuWK1g?=
 =?us-ascii?Q?o+LLmJczjfxugmEzW6i627Qennlheu7yLKQwBDVgdLeomk0p50bzZqEVZ5WA?=
 =?us-ascii?Q?tkisbR+Uk/q3ejwr+udRKe+zeg+NHyJBJJGhKkyGEex67HUKO89prVFSS+E2?=
 =?us-ascii?Q?QsIRpt8MyNSM2mY8Qqbwxslz6wa5zFJ+ywcl83o/MCpRJvB02LYjFh3YTpGr?=
 =?us-ascii?Q?/EM47evOfEgupHSeCx6sPfA+9k+SiRoEGbp?=
X-Microsoft-Antispam-Message-Info: Lp+5CGNXuLCe9H86Ii+s2hQIFYmpPLQlyZcruHaFCwId3Pp3vVXr7ftfch7VIGo2Iu3+hcTUUByuM3S/gU+ZedWy+bEXTqpmNwXrQT6TSwzrcfjqA0pFVJHzFi3Psll5xBdlF4ZkY/4HrHkqRKfZNHLtP2nyadOsHMA3xtNme/aV27ql84Cl0tIgdTvBs8Nl
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:YLeYXGgnPRaYBHuuElvwNzqRa3H6qiKyBiPVnxXlIvXOyVCWEgss8htxzWZ4aSxb6xGNEY+pVntAMfruhqkqSlIF663RKnbf5n9xV58dfA9vfPXLIWF1iK9b9gaeO+UKPQSixf02mA1XreE4y3H8szBRiQN9tw65iGh9bQiGrlxwifcMzdXH3H5BcqY3BU2SLzmrVOHzRZ+QqKufKT3XNgiFUbonUkBrT57pVsFFB6tX2eadVnloCLRHCoBxZd6TDTTA6kXN3ybYCmwEi+VBtU5i8msPkYMEvqHikY/uKKROzS6UJ0BrWyfiYNz+BAm9nLzwWZ9ZvgZgEVQilqs5Gg304nunM1YvbiQNlQrjHx/qzVYjH4HDk4wBZJ163yS2IRPTwXo/Uvcfb4R1hLnjRe7w1ewsSAp3+BrZuq+qTBWu6uvlzqfYcIs95XjQ9Qvw5ikm+UoxNGf6p/3DPYv+kw==;5:c+FnyR/GnMg5L3w4L9M8bb/il3MoHfMcwpUXARJQ0/sFOxBYUwbqqLAKU+QjqueeWzaIIjGH4MrdWT0Tsi/xIbyheFQF2XPaPXsqhXin/exbv2wHd5f/y1jU4oaswA0M/h9Rouvr2XUJiSYSsNvNxmZbA98fChc1zE640xtXut4=;24:I0keAu2GTAQNpPE7QtjC0G0LYRkyHAlhdQczZpYA47RB6rS5RS7yo9B53T66wbhWNmNRo1CeIBxVEHH53Zy1WpzH/9dllq+d/ejAcd1WMec=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:byYQr86UkoW8BlCV3uy8DFnd2iiQjOIUVIbcuxVkAyUWTHYD6pyFS4pWZZyiD7sNaqQulNm1o4MhUmpRDr5gQFZvpvi7jp6cHqelWKc/cGOS3G01w/x68PJDSC37DS/SNE8C/r5HwiGpiqIB22wAahzz6vmGzB0gYfuhK12YR4h8oez7hx+bOsZ1zOb2gPoxbXfcwiQUw+cbgnaXVZALk/IV6KjWzCGxHNjHUJY0qNA0K/Wp+IbouCrfElycId0o
X-MS-Office365-Filtering-Correlation-Id: 998d64bf-b321-4c57-3581-08d5a8ec8484
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:33:31.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998d64bf-b321-4c57-3581-08d5a8ec8484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 09:35:54 +0000 Peter Chen wrote:

>  
> > >
> > > Sorry to reply late, are you really care 2KB code side? Since many
> > > users use EXTCON to handle vbus and id, it is hard just delete it. I
> > > could accept patch for your specific platforms, like:
> > >
> > > +	select EXTCON if !ARCH_XXXX  
> > 
> > The patch doesn't remove extcon support from chipidea driver.
> > I just want to not select EXTCON unconditionally, but let the users choose. If the
> > users need extcon, they could enable EXTCON themselves
> > 
> > I just searched all the dts in arch/arm/boot/dts and arch/arm64/boot/dts only the four
> > dts give extcon phandle to chipidea host, other users don't make use of it:
> > 
> > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > 
> > arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> > 
> > arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> > 
> > arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> >   
> 
> I see, but I do not want to break msm platforms. You may try to create Glue driver Kconfig
> entry for chipidea like dwc3, and let msm depends on EXTCON.

Got your points. Since multi_v7_defconfig has selected EXTCON, and
EXTCON_USB_GPIO(which depends on EXTCON) is enabled in arm64 defconfig, so
what about:

enable EXTCON explicitly in arm64 defconfig?
then add this patch?

Is it acceptable?

Thanks,
Jisheng
