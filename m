Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2576399-1519122162-2-15376439045769571964
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
    t=1519122161; b=qN+ZMS7FC43xgBlJF63Csg04PRjASowk17gBCcTINY0Asno
    psU0aUQae+j1NnzUZ3X8/zcoP6wBEZ1xUCeUoQ19GSOfDPptQUljPrxjNXSxX/+T
    mzArv2zS3K0Xa29Ux5OaC5bMF7wHR2zQ1E3Au6vDFWQNy4GH3YlBnk1P3P1MMP63
    SvKC31+vq2nGr2PhzIwZGTWKDXg8xRxbl4HkjvJG30Wwa0pDjpTm6NRq+501NDTr
    1EQNAIKV3Def2T+61+QNMhD+FX1xx3+b5/YZzWHKTO+5MN1qqdTtG5iyaN5jk/Hy
    PAOGWJUdL/Y2U4z01mxtT3btYNsFrb9rwBGdPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519122161; bh=mnrxs+ELGi3euNDhVa8dpikReCP2hbMbKJefLtJIwng=; b=N
    26cL4j+OU/md7YWY2qoQVzy0XxbFjnHgJ8ob03j7m8uzDrpfYhH19D4Lvr5nN0Pi
    22hFBm5U8EwnLvRqUXLpjzNGSixgs4Pr0hUkmf8FwoXdP+KNMuk5zPR51Cj3Z/aU
    QDjyR2mba0q7vxNe5sONi5eeJfB5vD65RxBSUJHxiuJFz0wdfPCV5RP16zM7YU1Q
    boX4QfUUtogX3gghXFtlWPFRxWEeLEeVcu1k9DDhKdx8pL+LLqR+U/ssSaHUSYBR
    TooHnwH6B6Ea5tThhChGssYoB13BmL6nWQrviTRjQorRhGJN3BsthtKsbM8667k+
    /oMklI7uXBYVFuEmx+lEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=hZWytShi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=hZWytShi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBTKW0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:22:26 -0500
Received: from mail-bl2nam02on0048.outbound.protection.outlook.com ([104.47.38.48]:39078
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751338AbeBTKWU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:22:20 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
Date: Tue, 20 Feb 2018 11:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(2486003)(23676004)(478600001)(230700001)(2906002)(336011)(186003)(9786002)(7416002)(77096007)(31696002)(26005)(106466001)(316002)(58126008)(110136005)(76176011)(31686004)(65956001)(36756003)(65806001)(54906003)(47776003)(64126003)(63266004)(50466002)(83506002)(4326008)(59450400001)(106002)(53546011)(36386004)(8936002)(5660300001)(86362001)(229853002)(2950100002)(81156014)(305945005)(356003)(81166006)(8676002)(6666003)(65826007)(6246003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT010;1:oUszIRjyBD8jV9EMatX/ILxbZCrUHtpNm3ggISFAyKMIQgVYPunOPBcGnonHj0eMyRg2GNuUTiJ14b5rB+lwaIpI4djf2lYiXtUiWzFhLoAzIkoJBX1msWADS6eR9IeM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0638b258-c7c3-424e-f09b-08d5784bd081
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR02MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;3:eF+mbUPI1b8qdaMLfbqvtg0u/rQ1fXwY5AGNGrAw4N2OHWHgR0y+X2JOgqO+LfkE3hQd9sls3xj2TPZxq+aAG9qtVoU45XC/gZH6Lf8majPlu8nbQGKD8HAvp0Xn3rvOdHxmIshDLDWhxQ5JolcmOj6Ag38q+LtmC0TXiibKxrXn5960hUDE3iebIPXTZbvDpRsmcuuqSY2GVL8ino3lJx4vWbbArItQF+D6j2CaXMbgmkelqbowoJkFeNyNK1Kw5dZi/QBg2eeoUtrVSPNNBniDgirB9Wrp6vskpKMmNRqDvBZFOeur8QxnmM49SQAG+dxZcV3Tvz/99/pnVCEYONEIK552q1Jh9BK2Yo1Ibmc=;25:ojMOOKQjHlQBCbi1SyswidEy1YAP11+zwTJUilThcyUzzEJBYD4+Rwd0iniIDBYzyGCbGNB0MAKkBw1lBDDYdzVSeKumzY/hwH96pivsVSGUF5zMCpC3Fd00QYC4VXRKcUxval21uaQ6eKtXYAt1uwvcsDMbGfC8UTUx58lICwLuGwEAJByUc6EHtACQHpuw+8tby+/bUfWJaQXftHCp2B8qvcQQKoDRt6wu8wtWCdyU6R2OcOFDLWLHcrxhI0OJsj0oxXHYOvINrFdrvFgvXAEErwcpL4zNrPtzvvpviN5RKthCRfn8i7ZdaFxqTOImL+h+FtylQVos/kgCHFfXglBDRL+bv6UVcuKLpon4cYE=
X-MS-TrafficTypeDiagnostic: BY2PR02MB1329:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;31:hMkTEtSbk0u8kC2NRDgBviyQ+5tb5X0mFU/BsM4LsSjS8lK437wlkreY97UOXcESH+MbmxUMPIr9wm91LdnOrxgDuVCCHutPk4lLVtW5iiA81zAnRD69dlJtzV2hFYtnA6LiIHcsfv+RnsYgZFQ16vicksk2KQxw/aN8Gimk9RY776CS7kVFHTZcHaL/jwz0GEbEOFv/U9zTS8HQYHvQoCL3EoG31/ZmtQToKEmxs2Q=;20:OrWsS/Oe86432nk41Ji59PUO3h63/8Qy7roKjyqpTJbF1BoI26E+1Lc2Zn/TKQLTtORSlx1GxkJxh3oPxqYOaT/Ko3TQ1fd60Y+uIp2q7/ewOVV+yXjvy2IzK5ZaWCjMo1pUaMTQZR1+6/TiG4k/ggc1CzchZfb8bw75svQTGEbekQF2fqitWVBiICrxd7jnb0Hg37WLKx20WFgFFjRrPoQjLAN+151P9qf7zot7sPCs8y16mSdm/OZSkG/gBG9tgbTqSyUMrWVlptPll9NKy4H7yQB9iBIz1kQiSqvNtcLYhu837rFcTJmxGA0eYzDZIrBuv/ygK6Ijfjz/6gHwXpXkxYMwqpdk/wAPHTuMuyYSmkS8h6zZ6cV5SY9rdZpX3h08BzqTkvFxXPtJLGzuv3HDu7ep9tazj8gtXTX87qMPtnY3aHbbH9vPvIrjEuMUZ0DUopGOhR/EDLjlae6ZSzWZoS2rPf5wifAi99UUqWdUIwu+NyGLBXjeeh31z1wE
X-Microsoft-Antispam-PRVS: <BY2PR02MB132900376EB182D539FF141FE2CF0@BY2PR02MB1329.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR02MB1329;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;4:yCh0X0e9nSHJxR81cvAdSZRyz4A11jS8mwMIKJRvGc/dCICqmvD40/Q8fWPpQVFm3qndlvyc3OVl/BMq4SJxx9b6R15ROq9CZTUUF3jxA7VJYE43qobA0jZR2BU+dRHzHFpqncIQZW8v4AcbMrYr+CnAwGm0EzH6aTR3osP7O0POJOOLufjt81p4hvieSRg72WJk+UTrnNXAH0gJx5e9WItJavaL3JuW47KN4hu7Zj9SkQMB1O1nxxonjZurv9lrvsmJwAxNqKbbtm+wNQqeAQ==
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxMzI5OzIzOkdYbWFBK282ZmNic1I2MW1oUXd3dlN0Wlp4?=
 =?utf-8?B?VFc5dUdXNnMzVCtuK0FBK29OMkRucXpSZDlsbXUyODZpOW4vdWp1dmU2Q3No?=
 =?utf-8?B?SENJZmpqR2JKeWNtVVJqMms1OFNHeHBDbEp6RFh3aUdYaEkxNVc2UlphS2I5?=
 =?utf-8?B?eHJ2VFVXL2lKa1pZbVhLRFkvY0Z4N1JKNzJpU1E4OU5HODZtTHBUL0MxWExi?=
 =?utf-8?B?ZG1BMjd2SDVKdFRTdUZkbnNLV1QzRFFYclFROUx2SHMwSTJ6VHBwM0FEcXlG?=
 =?utf-8?B?dlU5RWtGckZhM3JSZXY5N082U2gweHdrekMvaWIzUzZPVDJTbXJSMnBXQXl4?=
 =?utf-8?B?OUg3MDE4bFZEbTRMVlM3VmZpSTZrcFFQQ010bzdyTWdOOWpQS282MlZWZ1ly?=
 =?utf-8?B?dmo0SzJwdllFcmhsWVRhNlRUem4rdEtjdDUrdTdYcEJPc1dkTlgxZmZNMDFH?=
 =?utf-8?B?bkhJaGtRZnFsbUZIMTc3S3BLNDJuVDlhNTA2ZkhTZkFUZE5IYnU1YWYvMC9z?=
 =?utf-8?B?aUFuK1h1NDhGOTY5SmI4TjV2NjViQlNLQkMyQ2NKYTJJWUY3akxzYVl5WmNM?=
 =?utf-8?B?bys3VnFWbkp6eE9Ncm9RRGpmZ3o2OXUyVnNxU21CL0Q2UGRiL0hPRTExbjFv?=
 =?utf-8?B?b3l0aDlNWDUwV01PbU5WbEFsQ0R2akgwZ0ppRUU0Z01rWVM1eG9GR3ZUVHJk?=
 =?utf-8?B?Qm4vZEE2VDR3SmRyQk9ET0lvc3Zhc016Tk92R3dTNFBZT0ozRFMxYmxRbVFl?=
 =?utf-8?B?RDJyY3Z0M2E2ZkV3bmRDakZ2bVlBdGZWc2dLbGJ3NFdkMkRkVlV0em90ZVVZ?=
 =?utf-8?B?Q0hCYmZwYU01L3VwUkkwWkxlVldQamppbGRYeXB4M1FxekoxaEdLR0hxazRj?=
 =?utf-8?B?WllPdm93WmR4UUVnQ3Y4b1hFNmh1TU45cGx4dmt3QlY3VnlqbEk1cUhIbGxs?=
 =?utf-8?B?UTlZbElyUTlsdHdPSzFBWkRLTUZ1NDZUL2JIc05VdjAwN05MdzgrdENNdWx6?=
 =?utf-8?B?UGhVaHJFSFpSYWxYdzFCalE4KzFhSDBTU2R6OFZEMTlOc084MjRjRkNjbXha?=
 =?utf-8?B?WWp2dk5Vd2x1R2ZzWXAybGRzaDlrakNFWVhNWDVTZFhIVWVLQlBya0Rhaitp?=
 =?utf-8?B?WHk5SjRueXJCem1qSTRVNXlCYW91ajJvYTEwYnNVTHByeDhSM2lCaGUreTFP?=
 =?utf-8?B?c2FhNnN0d2lMdjEwZ3E0OWx4NDkyemZXMk5tNk1HNDQ2dDJVeVRTVkJ1VitO?=
 =?utf-8?B?dU43ZTJ1VTMrUElxSGpHaHg3UjZMNVIxcTFuYUhhdkpxRzNVRG1XUVRtOEJx?=
 =?utf-8?B?blBlRWZobmxZdktvWmtreDNsaFRUdDU5WVhuenVhQklUdVhXS1RCcmJJWFV1?=
 =?utf-8?B?Y09KMWVjL1ZNS0tiSHdhMExwSDNybmZ3ZzF4dHZRd1NyY0pGcHZnUnhBZVY3?=
 =?utf-8?B?OFVHQlN4WDdqeTNZZE4wcFdWRzVOZ21pb25IemZZbkZaZFZxNkg3eVNBSml1?=
 =?utf-8?B?aXdud01TenNYMzBILzQ5R1BldXhBQ3B6TTMzWUd1T29FUTR5cE1VOVYyekxV?=
 =?utf-8?B?MkwzV0tWbmppRklDcWx4Z21STWdpZk16b0k1cGZqdXNUSkpneWxlUS9sVlV2?=
 =?utf-8?B?Rkp6M0hiOTJFNHRiN3JhTVlCMEkxMG9OMXRFNUJjaFBwaUNmWnBmcDBzRFhV?=
 =?utf-8?B?NjRrQ2JsdGUvalpGNVFpRU1YSWhjNW1LdngyQmhuSUlma1hTaXNvU1JTQnpj?=
 =?utf-8?B?MERUTC9OQ2FDb3dKZ1haUT09?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1329;6:Td3bhWibC0coMxRQijV+WSBw4xhszlw+BEC1nToq7xh4nkf5/DcT10qz2muZrz6MG4UcdgrwqS1XwuunhXjzDJ2WUisWxZ27tYjai+BdTy9DnL/nZXOyEgBaxglxcXVWIupBI8808yG0jt/6hXhq3fUwWpQwHQCpoo/Vhit9zlku31aqZd+OYs020qyRZ0sPEnL+Gm5Y5wQzTIu4Rg3PDNsoJ064jl1TReLcu2XNe5DWX8OxCNGpeevZHKx7V2ty4vCoHmJt/dr7xQt20kxTP50Chl1Zq+n7gdg1ZLwfqd5n5yn2CAgQdjdwhyBmXxsLGGaRXc4Nxu0KBvwQLfFRgviP+83aaX4G489l592zHMo=;5:/4veAfjz53oaPu7jBF5ARR7P6tHE0uWjZzURQ2oLxwVcyoh+Oc3LHLHAhl+dlyDjDi/OM5PvIxo/jm9L5Gm7PTpu5y0jateib+78UO514EYA0HenZhK2zqh+d25+yJUCyFsDWPQIy7CAPh+/3zvywhXdisBXOs2Amq/pAi1mG+4=;24:2sYEoNNbabdDgHsPwY4zkh9rlkdrDiihGrstHqmPzKSNoESVonMS0OHgPRFP32y4jW45v7G5440n2zYc7xTHGazWQmrl9JcQ7EKODy2PRl0=;7:8PdRj+hq5AostqAqAKpeTG8jB4DJITPeWS899zVLdZgw/sYtB/BsKL00FTDKUYoCxZAO6qdQDLOZLVcDzDGG4hAHG9/KV0HLHTWQy30QO8w6aSBX/nwCHT9dfGA/g7m9Oag5MxWrm3FvjB6861IGd3zdNC1idcRPGmLybCfIZpd1oAhefI/9+Uc1G2Fit5Mv64adLPL9V97dJC2T5OAoFLRJ8WUbp9uUPVxttK9ArAdQ2TQ2UjF3+xapiUuPKmyS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 10:22:15.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0638b258-c7c3-424e-f09b-08d5784bd081
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1329
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.2.2018 10:40, Geert Uytterhoeven wrote:
> The cdns_uart_port[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")

I didn't find this sha1 - patch name is this one.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
>  	struct uart_port *port;
>  
>  	/* Try the given port id if failed use default method */
> -	if (cdns_uart_port[id].mapbase != 0) {
> +	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
>  		/* Find the next unused port */
>  		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
>  			if (cdns_uart_port[id].mapbase == 0)
> 

Below should be better fix for this driver.

Thanks,
Michal

diff --git a/drivers/tty/serial/xilinx_uartps.c
b/drivers/tty/serial/xilinx_uartps.c
index b9b2bc76bcac..b77c6477ed93 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1109,6 +1109,9 @@ static struct uart_port *cdns_uart_get_port(int id)
 {
        struct uart_port *port;

+       if (id >= CDNS_UART_NR_PORTS)
+               return NULL;
+
        /* Try the given port id if failed use default method */
        if (cdns_uart_port[id].mapbase != 0) {
                /* Find the next unused port */
@@ -1117,9 +1120,6 @@ static struct uart_port *cdns_uart_get_port(int id)
                                break;
        }

-       if (id >= CDNS_UART_NR_PORTS)
-               return NULL;
-
        port = &cdns_uart_port[id];

        /* At this point, we've got an empty uart_port struct,
initialize it */
