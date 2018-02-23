Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3019937-1519393343-2-86237347433045488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519393342; b=WIw9Qhp4rLfWvWcXATa7rAVs6YosScrzBC2W4GBrKu74KhY
    VV0WB4crjUqyPNHIU6R0m0f+fuQij6uuBJ3dMWoSjwa2GouJ/q2SSdhw4loql+0q
    DzaCj+XdgBF1XZDCX89z9cDGPcfCjj9IQGwAIhhZvteD1M41vTVZ14mTO4M0XquH
    9Vrm5zq+2Lvv7U+YfXNcqtJcgQ3u5hMCCazBQ/rrDJM+qExqWR3Hb8eLSfVdgHz2
    0saTZYy+kRcZXvS2rLqym+CeHQtbK+UOc7cVbvBdkI5FC5uF4HAujy9lJ+BCPs8h
    NhPZIJu6ymmtsutVpJE45mukHNu7u865B+5S7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519393342; bh=/eaho5WhfTa4sUMo7M/lQewJnyTKPhGOs9Zcm86Tnn4=; b=r
    7b9T8WMjoyC6eXiQooh0YzWf9DJOJlbWPQHmpnvQaNpUgiVvSHwlaxDg8PkU9DMY
    h121brkvbIvicwLIXFW+ogDlORBZvk+VCFjbvXMoE7qOQ0/c25wVqC4ZH7qnRqem
    fbJibEwJnBYCmngghYYWPGkJjXqIGYjHrmk1L8d81oZQ77SW/1LSzCk/MmOq3BN4
    FYbDZnUuG1QzCDzR3qL1qPF4xtewDSaEnLkPyd4qwU6LdjKsTsP/Q71vxso56kYg
    TBosnEml03XU25tQMuqYDp+EaEUGKxsHx1fMts1+g5cwl2kIb9y27DbzfgukbCwo
    oJkGHF5p/tacrmh7Fj57Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=pZG+/gDf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=pZG+/gDf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBWNmG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 08:42:06 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:33696
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751762AbeBWNlv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 08:41:51 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH v2 9/9] serial: xuartps: Fix out-of-bounds access through
 DT alias
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
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
 <1519393117-31998-10-git-send-email-geert+renesas@glider.be>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8e402b43-e773-4a44-6a0a-6bac2e46aaa3@xilinx.com>
Date: Fri, 23 Feb 2018 14:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519393117-31998-10-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(53546011)(36386004)(478600001)(4326008)(63266004)(31686004)(86362001)(229853002)(230700001)(6666003)(2950100002)(106002)(316002)(9786002)(65826007)(77096007)(6246003)(23676004)(2486003)(76176011)(50466002)(65806001)(2906002)(65956001)(58126008)(36756003)(59450400001)(110136005)(54906003)(26005)(336011)(305945005)(356003)(31696002)(106466001)(5660300001)(81156014)(8676002)(7416002)(81166006)(64126003)(186003)(47776003)(8936002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1462;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT026;1:c6tEyLbc8tQTQA0xn9IkB/GqjJuLQTntUL9fWGh5oRGdlprQYVqD9p4hTonEsC0UJ1VJXkFpmFADbr4yckHeb+/Wi+HEOq9N2igSyHfR8umfEwIgZQNvBaGTCqN7BPGA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 372b88f4-f37f-40d9-0c4a-08d57ac32fea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR0201MB1462;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1462;3:Vg00mhKUFAodxR+SHEDXtBypfzI7x0oyZGU0NFyFcDLeKLSOrrprdBDEb0S3DB8qVWQfs39pDVsm1ie6Xdmz74w+a8M43VY1BkJkEnCSoSH/3dJRzcAQwu+JzjkCdCvRV2Jj63zdzYOpw3yPx0UcFj6UBYr6IquB8bOt64p8xE4HMuUkbrS1HgOVZcXVsoSuvrRpPQE/T3HyG9+S2HQq6DmErn2qrMJTE3VPA0+M6tMJzbUyttzfDjfJ68EC7p1m6h4jWo6N9UXjQ7thutCJkK9H3FTsL4V3LrYqMKwmToFXlZRMz4yT3EaHbvt4Op8y6CZByEeZCXGBu8HqGoowGErZffyktfTo3+mAFnlf9Bg=;25:5U3Ay5egEz78qvg9PrQJQedO4gCJ49of0aOy4nxbBs6E4nShq4gYaPKbDeKSRbtRx1ZNY7KcS43ODzuLh22ogLAndFJsKbk51B+8J+yhL1TLQs1KEWUcMBriQmeIlVOnT8tPAUHSadAM7BMG3BLWDHnJVncHtAsCnCBn2j3hAbvhF74gSjYa9a5jpvVMJinoxXNNlygFslt8FdPFBTxXMSMMUSkIwPee6Qe2HuROR+fBw5AB/iWQnVqDkPcCUCfkHAsonpyTOTeA8NDZbPd6vAoJPeUTkkkxdzDZKAYcjXwwQo3EyWMqmfOU+n4JpM5zgbvV7c8GaSxde7z8I1ESNw==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1462:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1462;31:Jpu2zg9gw0ouW8lpZhXKMDva3GK5AbN7f7OVIo8t/TC9RVT7+fc+P6pZN0e3ad+ivIpa0mOev81l4ncypiYFFQo37QQalMxCsJ3jgccC15HWPRWSiWz/E++CBY/a5mL/43ZTr7BLAFQFZNh6v6NUh+h91kL4ZIdzGuhUfAZtV5RG8eXXfna+EYeSn8L08zEu+BxSd7ifuFPrKn8H4pPAgc1rkyzSgl5jX+hOzcCkNCs=;20:OZqFqNODKR4grjqXLOjUp3JKCJVL6yBbD79zKPVPOAL1lAZ6gc93fT5bNg15794c/M1HBpgG2w1qJ9OdUZ+vt1kj6N18IvObe3wbZDRAbps/djkXYaJczlXj9EkLh2NSbt0X/Uo2EEr9gmlNNzaSoJCP/pxOMKojXGVYpZvmhmw8wwmFfHMXRezIcXjgHGKKsNE/B4OYTTwP3/8UeSbnPkUmM32Z2r7DUWpgzknU7Afp1Kup8O/3zoPq/dDzWcmWHsQxg8N+PeefAU3HKQmJfuWA2EIFUaO3eQJ0HDs96pED60Fm6Suzk3HMLG4NFc0RR0wGUChZ+LdCygncujxM7T2oiachUsSIZnHzTgMALag1jsaJfTIXk6Rm+kwCUxP1kqZPa2HWES5Zc6Kq098d+vKeMffeHrkoEDkafIYFPYSEzeONHHOwVNqUyJeqL47IdkUyyv1M6E56G3kaQFwyqeXKPlv5GrZeMMls1ZVSvd+0OODMYE404uYFhh2jEWJ+
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1462D18390A1C5EECBDBF055E2CC0@BY2PR0201MB1462.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(93006095)(93004095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR0201MB1462;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1462;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1462;4:9JWxqfGe0fYRhsFQRLhLjuhUrjMLJ3XEMxCC8uVHlBTys7uWzSh8PEdo/zL7VZ9ZGV7fk42pGVklXG2+Q+GjUATLyvjtstG1/1GEyEDASJNI3LDyYf4wlsu8igIkZ4e7fIrLqR4h8+Y36OXu1tCE2kshke7ghhqdbr29384SfRvcMLPaXyv3GPlICqtUYhMf8C9JcFE5KbTmtaJ8cpbwCS0qlMCnFxbIq6vwneRnII/9WL+UXBdgBu9OJNFPsQMZnz5zP+uzDkdPBbrNhMukGxs0ZXwtR2AaiIJqP1RNVRqnza+Rxz2iPFUKfbr4bkz5
X-Forefront-PRVS: 0592A9FDE6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjE0NjI7MjM6L3hBU1cyRWhwUnd3QldoV3FDbDBYcGpS?=
 =?utf-8?B?aitNdUNiYTRXZjBLaFN4amUyWE9KSHRYNHRmRGh0em5UN01hajdiRGhkNDly?=
 =?utf-8?B?L0haazV2OFJGK1VNYVphby91dVN3NFBtbXBzcGhvdW5nSUFMV1FSS1dBbmtm?=
 =?utf-8?B?bjNjSXc1Y0ZsY254bkQyYXJ3cnBXRThxaW56Ly8yKzFtc2lzTUt6S3VmVzEx?=
 =?utf-8?B?WjNEdXFlTDlxR21IcVcwOHUzcW9vUWpURUFWbDYxOVZuQjhsY3R6SUV4VSs1?=
 =?utf-8?B?OGVJNkIvbmlLN1NOd0dUMFY3WXBQQlk4WGJra2hTT3drQ0tiWHlFOUpJcE16?=
 =?utf-8?B?MWdRL29iYXJqOHAwelFwNjVCREtnSWVhTFRHdlQ4a2pJRk9NaHd4a2lZclVZ?=
 =?utf-8?B?TExzLzZuQkQ0VG5HejVPUTU3ZkIzVVMvMFBYME1qRzJ6SjYydlVtS1JSYTRT?=
 =?utf-8?B?d2l4ZlozMEFVcHdRc20rL1oySm4zeU1kUlFjd3Y0bHMwL01UVjJtUVJNNnow?=
 =?utf-8?B?QjJPdzdvZ0hmY2p0WDJ1VGc4SVRDek9ZcFM3aE1EUWlZVWZRb2k0U01DL1hZ?=
 =?utf-8?B?UWtvSzFJb2RoMkV3cExSSkRuYlg2UkhxR0IxUHVLOW1wUlZPUzBTZEJ2NDdp?=
 =?utf-8?B?aldiY0pZeHNUaEFUODd4amZ6elB6Vk0zejNMSlJhbERmYzUvZ2hYanFvOEor?=
 =?utf-8?B?d0Q2T1lKUHJxVUxXZDBVNFkrRU9iSE43b0Rjd0tiQ0pqTk1lWVI3OWZqRzZx?=
 =?utf-8?B?TWJEdEtFSzVCSTIxaUNjTmNyZUFoRzkxdGkxRGVzSVNhTDUwTTRvQUx0Znk2?=
 =?utf-8?B?Y1hyRDdta0NwaDZCU0JEYnhjOUd5R09oakF5OWFyTGVqZXFqOFpLYmRMcnY4?=
 =?utf-8?B?Z1gvblk0RUw5SHNCVmlXKzE5VEpwdjl2UHRneHhXeWg1Uk5OS1ZJalhWODc2?=
 =?utf-8?B?ZDczTkhFS1Qzdm40VzBIaUg3M3AremVTaUNoamVTeGoyQVQ5enIxVTEzblFn?=
 =?utf-8?B?NEF0R0MvMy9wNjM0bHp3VG1wSGpKdHBNNm9vQXpIQzJ2ZU40dm9nYWFxeEVR?=
 =?utf-8?B?cWlJb2FaVkhmd2hpSkN0YVFwVllCSGxKK01ncjFjUFRUNjk3cWtadTBTT0hs?=
 =?utf-8?B?WUZFSEVQNGFhYzh2MGNRZTFhVzY1WEk5cmdwc0VnQW94QmVyNVllUXRpTDl5?=
 =?utf-8?B?alA4RkErTHpoQnNxampuUENXbTI2cHRMbVhVQmlmRkNrZ25KM0V6MVFiVldi?=
 =?utf-8?B?NHZwWWlxMTcra3I0NXZkUWJKWTBkbE1FTjBjWVNEdzVFSmlrUEVBbEN3eFBw?=
 =?utf-8?B?QmdwYVB3NXg1d1lCbzUzQjlESXJPTi92bERkalYzeTd3cm9EQXdXZE9DQkxS?=
 =?utf-8?B?bTYrR2V5ZjZMY3dFS1ZtY3U2Mm5maE1tdmtlY2s3dHJmbkZhTHpsUmNYOFdD?=
 =?utf-8?B?SFFGYm5uWnA5UDlURkNkTHRUc1hsSmNFQjFwdmYyeldDRTNMU2FvKzNzVmZo?=
 =?utf-8?B?dkM0TUw5eStIWEVJNXhLWVJvY1JzVWY0YmMrbnBwWVhscVBwUkxqaTlCN1N1?=
 =?utf-8?B?UXRLTlo5aDdjRnVCMlpTSVlsbnRSZTNxME1JTitNYXBEMWVnNnUvRnBxR0ZW?=
 =?utf-8?B?TGtaUjVVK2tKajNtc29WQ2NMSFJoaWxDVzM4cGFBam50QUg1TXYvMDRtNXBk?=
 =?utf-8?Q?pxP6IwEJM2N0oGyedBn9qV/9O8IF5Nu5HZEUc1BW4?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1462;6:O5dMuQB5l9YPuEdfdYkDZtpgTcfLx5N/7J0vOBCGYv9fIHFyk67RvRGYt8wbsghrYkWGtPObWLphLpnqzrd6zWaSEgFOy/2/5wgNFd59/Hjb7y66jl3dpPzRPP6wFDl7vJ3iA03H0dLCdfDjyrN3MZNXcuF/5nUen0cDjbMt/f/hShAFooVL4mw7n+ONTEcPSeYx/Uua7OUanfpku7Sy6hAGexzchBB01Sr54FJrUSJLe6qXBCFfkeKTvb30F/IpoOT82nF3bubPOtwg1Dg5oK7M57HZ4wNA6hasfERBj0jHy6IKNBcilvKhQ2KddXfmSwvgS0CqR2aFn/LU4pHZdC7GiwwEGDo+JJiMc/seDHM=;5:Xgj1qx9k09LIta7gHSbY5CuQrgVoo/PNIgoJmqdSo07iwUV88R2RI3TYJVbEZMt757B+jLKwAtbF1BwxQbBUkgQDiUaZhHLOvNNSmdZ43PDst76fvhRh+NUp31jFz+/3vpl5yOaOfcRg6n89PzusnbFPMgz7n7b+tK16UL3pyBU=;24:l3vt6EA5rrjuSZs2tINX4lwL2gsu5Pk5Llv8HC+azzLtcro1xL/ljy0et0Cf0088lVxgp4lB6APX4m2uEbQU/S1wGMZWRPT5q+pe1D6Py9o=;7:jk6NjT9NfWc7j5yrPuU159QTqYGOGeRHY6inquumbLBAYDw5N4SY7deAuGJPGprBm+yws6T9WLPZrCJeBS26uSTUXSlrFvaZxQQLAHxJR4hfjGAyp1lFYgAN+7NbjSoWAc2nTUsSNX3Izeq5kST5m5rGU6PPZL2omkgyJrLFTHMmB8+XqRiKazH16stES3Orn8DRYvOi1JYTdhFAedEax+zFEvv7e7HrHCbMrcWxRFhY8dBlNWxQkPh8k+vqr2Tr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 13:41:47.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372b88f4-f37f-40d9-0c4a-08d57ac32fea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1462
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23.2.2018 14:38, Geert Uytterhoeven wrote:
> The cdns_uart_port[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Fix Fixes reference.
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

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
