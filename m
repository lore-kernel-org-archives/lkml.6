Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB47208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="WQkjyPcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB47208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbeHWMmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:42:45 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:40512
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729142AbeHWMmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CefhSPCoPM0D3r/Veqn4aYui6pBsCvJdId60h5G2tuw=;
 b=WQkjyPcF3ZhQu4LyDVe/8fzj1lLSNzfYWkcms4PxBt3l5FtKUDHya1hdAwnPFropUPUqJAy5hh4M+9FEey1mRRms/6qp+3BfVn0yP06Vt2FLmTh/Giyfhd0X+tAokScaCn9ZixUhyilPQOOtbKs2qRJ8jXrPEVqllJqqVy1HtaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 VI1PR04MB4672.eurprd04.prod.outlook.com (2603:10a6:803:71::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 23 Aug 2018 09:13:51 +0000
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
To:     =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
 <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
 <20180822131758.162d5351@ipc1.ka-ro>
 <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
 <20180822161036.4d69bdc1@ipc1.ka-ro>
Message-ID: <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
Date:   Thu, 23 Aug 2018 11:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822161036.4d69bdc1@ipc1.ka-ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0701CA0053.eurprd07.prod.outlook.com
 (2603:10a6:203:2::15) To VI1PR04MB4672.eurprd04.prod.outlook.com
 (2603:10a6:803:71::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e337ed2-ba18-4130-4f80-08d608d8be83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4672;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;3:J7DJbsh90RLu/G60qk3GP1WScAEmmBsWh9rwCTWV4N85OrglIOVK4C3ygtkcOLuvXBcMDVBcy353lIuFfZhqPqhwn6U5gtxxTj/e0gBZSvxFchLdLgVmUmhtdyFwpdw/r4aasSOfIT0+8tSvHxHFelhbBbDfrg8LqvCW+rmepq2L70DO47q0saOfIBtR8XdL2RXPTOUDklhbIGR47c9gcTtauNEascxoHUc9zdtiqbSC+E6j2b+TtKgKTi3s8eQf;25:yZQ703RJKhiJNb7Kt0o6SlTe5y8v/fAvJq1owhg0Xt9dh3f+ReqRBi1LIn3CLI7ZLH9fxDbSQTIPjsF+Aho6gWpVGaepNePrFRH4FU+1Deuq8YHp6KqD8az3aX0bw0UDmGxt+9SEB1O7tmvQXF/2G8ISK0uELagUaSV2o60Ra3je74Fw70EDqmHuxzDKUGQGrF2h9viEAAWMCMRnbj57sCwjBlv4XcAgB2iyRWJXjhPwwycbM1TpAAHkj7bfsVCvv3ZI0KvUZXCRDnK/1CuetcADKjdkmYPMBsYb+naX2o1JUUxz0jS7d3JXI2+WcUaFpR1H9cpwiAOcZVPiEN0Elg==;31:DxNMwf3+R8nzsKpVSaZbtKTAUQi+deJEu+RVgnP2n6/8Q4tvDRm25viyk2xR8IJIgAIzclcaeNKwEXB9Mw8NZmEoO1DukIG5Qp3IFcQkqQmj0Kg/JduM+lKl/k8WzgHKe98BsWomHLumjGJppDIyjfr/jAK+YEYFdmGs3y4RDE0zT4+yrjf4BhS977l+JUZHdPwmQJ6q3doFyHGim+TQD4LaxMuxCyL3QFSRn9ojzVA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4672:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;20:WbUd9MgYtfdMX9wvFw8M6dWg0lUjnx2hFoQYI6QRscQ6O8ovITqzOOs6WfovT0jLwlmfL8s2NAufVGkvvWR95QzbTixxsrv19pc/LpHErwh/DcC8yRcPWd54BMvgilGsDi6yyGrk74L4SItYKoP49xvq8WwUDlH2MIbrmsT3tsXVjovg4O9FxbeDvzwWs6V4fMc4eQxcufBMXAPuJp+7D0aVaTXLSWeYTPku4COHxcKuHmdtueHp1az6QaN+cyIt;4:kgH4FqCOKhQhmzCgLoEcQoQiMErbMnXJTq42pusDKHzmOuHvyzFpjTgh7F94zIg8gpaFmTL0bjP5OBBi4miKgFUE388cRQfgAhlznTXzWprGZVTpWFR2noxBki/mTQ2eSK0dDb5on9kCl/1FtICJEUlmgyVXN2/GEnA2Y7GecZzOEteMGx0iODv7+ZO24CkjJLvYsIaqLkBHuy3B+OPmxy9YjTda00Um1Rvne9h6HsE1ABB17iXf5vCBmSabkNxOY0mp+SaD1bB5t/ilBPJEEQ==
X-Microsoft-Antispam-PRVS: <VI1PR04MB4672D68520EA414EE980A0999E370@VI1PR04MB4672.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR04MB4672;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4672;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39850400004)(396003)(136003)(366004)(346002)(189003)(199004)(47776003)(5660300001)(6666003)(65826007)(6916009)(2906002)(305945005)(72206003)(7736002)(97736004)(66066001)(65806001)(64126003)(65956001)(8936002)(68736007)(81156014)(81166006)(105586002)(36756003)(93886005)(8676002)(2870700001)(50466002)(316002)(31686004)(76176011)(16576012)(58126008)(67846002)(53936002)(26005)(31696002)(106356001)(6116002)(3846002)(2486003)(52116002)(23676004)(52146003)(386003)(53546011)(54906003)(86362001)(217873002)(85182001)(486006)(2616005)(476003)(5024004)(14444005)(6486002)(39060400002)(446003)(956004)(478600001)(77096007)(16526019)(229853002)(11346002)(4326008)(6246003)(25786009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4672;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NjcyOzIzOk5OSHE5cWhVcHlsZ1dxYXJXdzU5VVlJWEsx?=
 =?utf-8?B?M1RaMWhXdjhXUi8wY2dRV2RqRXlkNU5xUDFWT1doSXE4RGs2bEIrT29zNk5o?=
 =?utf-8?B?cmo3MWNqUHRCMUtaS2NhY3kxR1VGUnRaL20yZmRPRlM2dlFYRXQySUpvY3Yx?=
 =?utf-8?B?cmFlbmlNdnBuUXBnRFN0a2hhWmNvaUlJd2wvNlAraXloK2o2RmNEOVJ1aCs0?=
 =?utf-8?B?VjJlcWZrQ1NuZEZFRHRJMHJEVTkxZEVlYW5YR3pNUG5RY0F1Yk4rdjZFSXdD?=
 =?utf-8?B?TnlId3cxOGlaNzJ3YmxtWFJvRFdjdGtGT0J3cTJnTjYwNk1vNDA5a2gxRm9k?=
 =?utf-8?B?bG00cC85eE1HMVNyWlNHTExPSDdLVEIxYTlRTE5RK2w3STF2UXVsNTh1dUlY?=
 =?utf-8?B?SXEwN1FYWm9Gaml3bmc4cXYrZnJuNTR5SW1DTis2MU9JOFRtaTJ1ODZzR0VP?=
 =?utf-8?B?d21VbXNUajVDYmRaaUNxZmhmWFAzSW1ndi9rQTArVUg4cW1jd3g4cnpoTE11?=
 =?utf-8?B?T2VUbUhMSk5QelRDV1IxZGExeFlPQVMvSzhYMWtoZTJQQzltTHFUZEEwQUdQ?=
 =?utf-8?B?KytVa3UzOFFFU3hkSm5xbkNBdnEyQXhIS08yU1EwWWZ2dmlERkE1N0FXNDVR?=
 =?utf-8?B?NFRYVXd5Ky8yVDFRV2VMNDMyVWozWUNFbWVMb2x6M2xuT1lweGdOYWhPRHF2?=
 =?utf-8?B?NGRMZjkvdjk0a1VoWlVxU096bWdscm4zK1piQ2tWdWNxZnl0dWJPRW55WE95?=
 =?utf-8?B?RjNhMGVrUzJKMG1zajc1dmUxRWlJSHRmNVhzTm9teDZ2b0JKM1NacURwMXM5?=
 =?utf-8?B?dWI1K1cweGN0a2pMT09oalJjcEtmbW85TnMxVzZTbE9QMXc3Z3QwRzF1RVVv?=
 =?utf-8?B?SWtrR0RhSDJLZ3dFK1lxRHBVblBaVzFYSXBZVTY3RkphNjRFb25KZGw4VXN2?=
 =?utf-8?B?Q1k0L0EwQTBJbVgraFREUTRzSW9zcVpNdFZMYlQ2bEtFR1paYmJFWGF6YnVW?=
 =?utf-8?B?bTY1V3dCb0JOdzBiakZWQmhRLzFMaU05dE1ycEc4ek5vaVhPWFlyQzR0TVBL?=
 =?utf-8?B?ckRFMWltWnFLWXpqT3pLaFNMaFVQSzBoNnlQd0Z0MThHalU5SU44Sy9HVjZ3?=
 =?utf-8?B?MzRzbEJyK0xpd3YwNE9GOFZrR1dGalgrVWU2MkNGa3pJd3ZMT3NRYVJYd1Ja?=
 =?utf-8?B?V0xwbFI3RUtIUEY0WDdwMEowNEZicW1HNzFRNDgyMERiR2dWb3NKaFhydHo4?=
 =?utf-8?B?WWorcjAxWVdTVElsQzJEUzJwNkcwa2F2Y3FuVjFqeUtjNXZwU1ZOUzhoWnBv?=
 =?utf-8?B?TUp6a1J4cDA5WEx4N2VBaUg2SGVVSVFIdVYzQUNZMFFJaHhyMTBnU1UvUXBS?=
 =?utf-8?B?VUp5WDBHcHZXaW8xVFhhVlNaNkVCaGlKR25BMU5qN3B1cGN5c0kyNmhSN3hC?=
 =?utf-8?B?UkJ5ZWZJL1hrYU5ielVVamNpNlpFeUQwRkV3SWhGL1NBTWZtN1lEaDhQNFFX?=
 =?utf-8?B?WGoxN0ptQ2xRUWE2SGdSaVJSVHRwL1RPQlVhQjkyd2JYaUFSYVRxeTl0SHRi?=
 =?utf-8?B?WGo2Y2pXVjR0Z2RrdUtFazhVMnlMd3kxaUZJMzdTZE9uUjdUTmt3OEl1NmVS?=
 =?utf-8?B?endPd0w5aFMxbGpHQ05MWGw3cFpUaUFnT1gwQlIwMXh4TVFONFVoeUxYbmJE?=
 =?utf-8?B?R2FyN05uWnNtc1J2bk5QVWFtZjRQbUl5c0NPQ1loUjh0WkhtcytwdzI4Sjdu?=
 =?utf-8?B?SDRuK3RwamlwTGY3UFg3aEU4cnhkNUlBY2xtWkYrOFVHcU9YaC81RzV2Smpw?=
 =?utf-8?B?dHhlZnRvMkRSTlQzeUNOU1JVSzJxaDdJcTZMQlZmNW41bjBCeWVxTTlKeTlm?=
 =?utf-8?B?YnR0OHRuY1hRWlZUNGZBUjhtV0liRWZjWFZVNnpNVG50VzJYVDNYTktaUnVw?=
 =?utf-8?B?V21LS1lnRCtFUkhEK2lLY0dQbWdRRXBac1ZpOFFQcm4wb2dLNFg0U00yaVBh?=
 =?utf-8?B?L3dOYWczWitkNXhwQTB5OG51YlBuRDJVSDVzcFhIdS9Ca0FOYVJaWE9TNTBV?=
 =?utf-8?B?azcyMFNDZ0crSTVhZ2FDVWxTL0lZSVorZnVMelM0cmtnajdRWjJYdWUrcUx6?=
 =?utf-8?Q?lfa+u7oukXFqq5uUDz9Dshxs7ZIokc/MpkISCqmQgkWP?=
X-Microsoft-Antispam-Message-Info: aqxX1BdSVGHpXZRQQvC7HpIqLqCDY6+E555P4Dmwgd91JGXKK2Awa388xxqgBhIyWBdmG/l0wm+DFdbc3wgIUlvqaREg0Av5owjNr4AVib88qKg1s8E3UHg+LuThhGdk5+NQ43HGrQPHAp9nWRF08NOhfy7s7Xdq90DStYt0gEESVvmW3CD3rJBjlJb5j6aZW8tnKboxypTI6C+b+1/Yqs9Mvlz13bAtKvT6wwI+FgLaFoIVr+H/b3gjZXqd4AM5PZ1/oYh/LXfwxaKFrmMMxVEsR31FFZEtSDmgJF0CVII1wT4fLVGQLZ3T8KkrkuUAsckj7VXqyh6AzhEH20Dh/q0LqjiW+Ns1B/UzUjWZJ/E=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;6:yHD1r7w7HmznJPjHUOJtJwlBpkKs9p00pwd12acnPiPXNCjcR6hQjmSGo2cotgm3VniAjtmIEvK5qoJWLs0vWWmH7oyRhooXjnqzFkQDuNxp8rHEpqLyJqXNljcQxp+hLO3Xs+pjCzO0scIjL8eZ1Io94KphdOfCHSMKqCw0ojcy1seBXJEhuy4+L135Fy/OfMVrqnRP+1Qs1CGm4BDg7aUG1V23kdPwG/ivi8uVAldgTjJH3qecQdSk/RZe0o8vbhTRjxghjlAFK/piGBVJH6AHf5/3/0GIih+NZW5wr2p7y3/8Vv+hXWwt8VALePuRgxUvaYLLOFkBdih1HyvQDMogFAJQOZYC3YNd9RutMwsDOOlVvuQAA9hIJ/juqfKfDMFA/DpE+lT2csmkPanEnv59MEfZut7/2FfQ0j5pMR0lTq3DeAfn980bt8DYtyCgGPQUsot6JGlwiFnojXgABw==;5:oQwlv+wZhcFBwhWiQnz2h/qVVRK4BVdAGfO6fHAisl56VXB/WhR0108Ru+UEjUQ2MKtHoVZTgvWBXTqfniatgFLJVrVa5UqXET+npxrDNddU4RZjXGedR1iW2kxsTznMeVv90HhC48F6a2XgnvXyPyVbdKgCgiCTPSz+BdfuvUg=;7:7lSMcDnShseIxz2l/kT00wPw0SAFMsWV7StbvDpYIJyMB3OOQGhsnR/+1KxoZMvmnqbkNTUn1eUqreA+xDnPAJpb+vxLdsYG6prn2xmHQ7UFdliBWU2kRuV9c3SrsAbBbTYF/UQRpAaPwRTRMhbPMaWotJQ8YTnJi3UZpTikpmTn9y1LSXV5MQtPo6NbodZSLyjzcIVbhrZreP3UkK2khlo5iEEeBSXRGYmklZs+u4tgnkkdkIanaWHLJEA4UF+L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 09:13:51.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e337ed2-ba18-4130-4f80-08d608d8be83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.8.2018 16:10, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> On 22.8.2018 13:17, Lothar Waßmann wrote:
>>> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>>    
>>>> On 22.8.2018 08:14, Lothar Waßmann wrote:
>>>>> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>>>>       
>>>>>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>>>>>> is disabled. This can caue issues when inverted PWM polarity is needed.
>>>>>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>>>>>> on the output. If the PWM is dissabled its output instantly goes to solid
>>>>>> zero which corresponds to duty cycle = 100%.
>>>>>>
>>>>>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>>>>>> with pull-up. Then switch the pad to PWM output whenever non-zero
>>>>>> duty cycle is needed.
>>>>>>
>>>>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>>>>>     1 file changed, 44 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> index c61bdf8..3b1bc4c 100644
>>>>>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>>>>>     	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>>     - interrupts: The interrupt for the pwm controller
>>>>>>     
>>>>>> +Optional properties:
>>>>>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>>>>>> +  pin to gpio function.  It allows control over the pin output level when the
>>>>>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>>>>>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>>>>>> +
>>>>>>     Example:
>>>>>>     
>>>>>>     pwm1: pwm@53fb4000 {
>>>>>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>>>>>     	clock-names = "ipg", "per";
>>>>>>     	interrupts = <61>;
>>>>>>     };
>>>>>> +
>>>>>> +Inverted PWM output
>>>>>> +-------------------
>>>>>> +
>>>>>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>>>>>> +output, the output level is always zero volts when the PWM block is disabled.
>>>>>> +The zero output level is actively driven by the output stage of the PWM block
>>>>>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>>>>>> +a PWM client (e.g. backlight) requested.
>>>>>> +
>>>>>> +To gain control of the PWM output level in disabled state two pinctrl states
>>>>>> +can be used. The "default" state and the "pwm" state. In the default state the
>>>>>>      
>>>>> The "default" function of a PWM is to deliver a PWM signal. So it is
>>>>> more sensible to me to have the PWM function as "default" and a "gpio"
>>>>> function as alternative state.
>>>>
>>>> Yes, I totally agree that using "default" for PWM and "gpio" as the
>>>> alternative function seems more sensible. That is actually how I started.
>>>> Then I realized that that way you end up with the PWM pad set to zero
>>>> until the first call of imx_pwm_apply_v2 where you can select the GPIO
>>>> function. On my system that first call is made by pwm-backlight more than
>>>> 3s after pinctrl init.
>>>>
>>>> I suggested to use the "default" state as a GPIO function as the only way
>>>> how to get a truly inverted PWM output all the time from power-up to
>>>> power-down.
>>>>
>>>> In my opinion it is up to the DT author what pad configuration he uses for
>>>> each pinctrl function as he knows what the HW really needs. I see that this
>>>> approach is kind of controversial but I hope that with good documentation
>>>> this would not be a problem. And as I wrote in the intro, it is absolutely
>>>> optional. If you do not need it, you do not use it.
>>>>   
>>> This is OK so far.
>>> But the approach with the pin being driven high via the pullup
>>> configuration has a fundamental flaw:
>>> The pwm polarity is specified by the PWM client (e.g: the pwm-backlight
>>> driver:
>>> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
>>> )
>>> The pinconfig is defined in the pinctrl of the PWM driver.
>>>
>>> If you have clients that may use the same PWM instance and require
>>> different polarity, there is no way to set the pullup/-down
>>> configuration in accordance with the clients needs.
>>
>> Hmm, I did not think about more than one PWM client. Is it even possible
>> to design such board? Do you have an example of such usage? It would mean
>>
> My use case is attaching different displays to the same baseboard,
> where some displays have the brightness control pin inverted with
> respect to the others. It's easy to change the compatible string for
> the simple-panel driver and the PWM polarity setting for the
> pwm-backlight driver from U-Boot according to the display model, but
> it's not so easy, to edit the pinctrl settings from pull-up to
> pull-down or vice versa.

OK, I got it. Though that is something different than having two clients,
right?

You do not actually need to change the pinctrl pull-up/down configuration
in bootloader. You define the two pinctrl groups as I suggested in the
example. Or more precisely, you add a new pinctrl group where the PWM
output pad is configured as a GPIO with pull-up. You add this group to
all your common device trees. This does no harm as the group is not used
yet.

In bootloader you detect the type of the panel. Normal PWM polarity? OK,
do nothing and boot. Inverted PWM polarity? Set the pinctrl-names property
to "default", "pwm". Set the pinctrl-0 property to point to the GPIO group
and set pinctrl-1 property to point to the old PWM group.

E.g. something like:

=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-names default pwm
=> fdt get value gpio-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-gpio phandle
=> fdt get value pwm-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-pwm phandle
=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-0 ${gpio-phandle}
=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-1 ${pwm-phandle}

Will this work for you?

Michal
