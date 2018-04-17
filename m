Return-Path: <Christian.Koenig@amd.com>
X-Google-Smtp-Source: AIpwx49PEhoOOJUhG2xqV2Nn54WN2yFJbstqpTMxZAeoUtgq5XtfO8yLhVuKGdKZzNSmkdgNnY+s
ARC-Seal: i=1; a=rsa-sha256; t=1523979235; cv=none;
        d=google.com; s=arc-20160816;
        b=ELPQzQps23kBbk8wy5PoOs+9EQI8CUZLZecE5fmMM5ZJlS8EC9bDc48kVg/uGVuFN5
         52cyAsRLimdBz6B7yzcntOzM64F2CIfAoVTvQg3b6yvCXnPLd+xXPVvjh9TmHuW8k/xS
         /2UcFdlfFgKklh+6PtIVg7YTWNHJtjeobnS6Gmrlsis23kOoPcDKHkTJFLowEw83t/5p
         MFSSsO6L8aFIwyfpHSy6ZrJ2qt47/NzDuSbVCHWqO1i3jlsn5iyR0EzkDrbEgwoLlyP0
         UoJezQarhElUGt/Yx7sX11rih5EEOCAckcm9YTdl8ch8eq5purQVjm98benv3aBen7/+
         E4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=YFwGZUrkx8eAOZY++arw1d9Ewuh+f6oVlU5NPfFVzbo=;
        b=hrLOUIVDuEH4FygDfZkZXBvpd7RZVsaIrqCer5kn/6Q+nRzUkD8V7nnwIjUtQE2cf8
         ICst+Njts7WZod54vXUmb5NapTJq1sU3Mii0TuFOIMqtyFs96E8b7nOPkT7AakBiYiiN
         Hr8r8RcUvY7wILyDrc8XPCfd4Cv5Z8NUi5DUdDAsmANCpDq6tgsjV24zqx5X/w4roiiY
         FmcDt5PZ7HUlQr6ywOuFekv2gtlkCpclyGVdGFUL7AF7s7HE/8pCpYVw/QMuhNTOFXKD
         ebtIJivTFa3A+sD/XXv4YFhI3pFGD1JWhq/ZPeWtw+V1HlMawrUg9WwMIP3r/V53C0t0
         z02w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Lrrb7OUi;
       spf=neutral (google.com: 104.47.34.54 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Lrrb7OUi;
       spf=neutral (google.com: 104.47.34.54 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 6/8] drm/amdgpu: use firmware_request_nowarn to load
 firmware
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 kvalo@codeaurora.org, arend.vanspriel@broadcom.com
References: <20180416222427.29683-1-andresx7@gmail.com>
 <20180416222427.29683-7-andresx7@gmail.com>
 <2c27b97a-5cb7-92c3-d4d8-a9d274a2f1cf@amd.com>
 <c5980ac2-2b7c-2a4c-d0c2-5eab0ff01a5d@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <459ec1e2-bb64-c5c5-75c0-47f443b35cc6@amd.com>
Date: Tue, 17 Apr 2018 17:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c5980ac2-2b7c-2a4c-d0c2-5eab0ff01a5d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::25) To BN6PR12MB1716.namprd12.prod.outlook.com
 (2603:10b6:404:106::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1716;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;3:gYwUPRldxlazlScIKT8vnJem4CWdeuk7wKZmGO3r9SOmhd2DprPYoLz11BLhEkx6IxppGfdKDTHVx+O8/iSLHQ4cLZud2kQ8FjcEOU8ujD4Ww2f0IDIg8elWiPhtBPnj3hCV8oj9bwYjqTjB0BoGjWo8Manhoggvqn/KBZahUwGKZa0NRHn2M5bOLebxIQsJ+OwiVA/ERNYd3VEQYhuS7KphfgxVyxtLFXx1f5PLVRsiZzLzW1vYt/DP8eEOQTtN;25:2uos7UnxbcUVOUVAoHx9E4LTmvFgs1tal2XcW/pIUhFJ5QjjLr0YuJ8atUY35QXnB3CF8g60Tz3er+iUnBunDjAyt6vha4Qvg5EX0uYGaLBpfitmbXoC3d/TausXuQg3oQHGliUl9zzhg/IuW+sZU1aZe5GECU7aQRjqUKGLMpRWPahj86TgUiQS7HW3IseY8X3xIAxUuHkh2CymSOZQQLub3rnFfJn0OBYLxKxoZJEEHzlrzlm1SK1yjx7s7zYnyDg2wbWhqU62/qv/SGXCVjXFag7d9ThGP2kGcZPzuOWHLHpNTblh89FY0zfSCol8WxAAiojBBSk3tUQvEpR5yQ==;31:nsC4Mrjx+3woP/oACMbXONsCskwgefTq1CWsLSRdM4IpQvuS3vfh6zTlm6lQSf8tO9WWMdbvIh4g5+cmpbsgB1XZVsENoyg2A4Xa4hpvViF2vF/RhP6t9r34DlNTMmBmN3RT4jw75oH5D0Wm4scfSmSXkKreiYPNT069aWazBjR+kfIDcsgtndubc33JXpCohoGVCO4b2ys34uGDZWUDC3Utr5uFpkIwT9h2f9DHd8c=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:DYSxNOeP7WBFbzTDn8G4+/pkBKUJlIMMwQczEbQ/QnnWQHgIwu5r3h97jJd3NGZoY6xfwhsuxs+FvHf9ooLG4bDu/6MsgIysw+SLaGmTU9X0U4CbwhMaXVtbUOzCBLJuYoidRFo4i4W1lx7PAHk6PkROGRToHwFU5Wg6QOopnPEYs3vB9yiMUYsZdU32pZvFydtKMkJ/ajCHJQGHDY+0rRscENdLh+wq9FOThBKUYLAgtjfs2vc20c8L+diNifktLPHg4EC/inY/oPF2Yq73kTYiLwCAbFZmOa73lUyoc+7eZUlPrv8MVvxXj/pIkNW3aJ5UgHH79O8ybVB6MS+f9bsNaroy3KWkF1JDWcjAv6I3qx70I0AYDx+c3SGGYHTn82gBVYvn6mQAjgABgJrsOwMl6zedoqcYXM3NO7eHYbxlhbZE2f0VyrMfb4fUlFr3zUdKGjZ+7oII878a9BuTd2QP7lTM/5FQre5FkuSwjgM5zl0D72znjfKnJPqD1Yaz;4:l0/Uf316fFwOycztthEWXh8DIGYstXz1UzAuLgOgoLiLvgj4DtdKggQPQsb71JyehyWgPYCdOdNAVrUfUFs5ZXxyy4BZo0Po+XLenGpwphQaAoNJwv+LfSskUhf2QxHyjbROVeOTiw+ZpmcRydd+xjIo4zlJKlXSV4OY6JZv2PMqv1iB6v1wklnyh7arOkadgXkXNl7cwsxfW8MMshegIhFGos6FgUwEDdEDMs6Q6GGwzyTaW1oYnCIiR1fwFBSMAHC8/1obwZXFqVcM4I+mPFeGLpmdLVwJHB1syf39PwtoIxRi3BUJMRleDfRT7bQa
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716CCA2C4C3B3B7A867C7D783B70@BN6PR12MB1716.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR12MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1716;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(377424004)(189003)(199004)(2870700001)(478600001)(186003)(67846002)(52116002)(47776003)(52396003)(81166006)(31686004)(65806001)(65956001)(8676002)(2486003)(81156014)(76176011)(2906002)(52146003)(23676004)(86362001)(575784001)(8936002)(386003)(39060400002)(53946003)(6116002)(16526019)(53546011)(31696002)(1706002)(59450400001)(72206003)(25786009)(97736004)(6246003)(36756003)(53936002)(106356001)(7736002)(305945005)(4326008)(2616005)(64126003)(50466002)(68736007)(46003)(229853002)(6486002)(476003)(93886005)(5660300001)(105586002)(486006)(58126008)(11346002)(316002)(65826007)(446003)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1716;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE2OzIzOk9vOW9BdUg5T0VTWjEvQjY3VFN1VVNaeGJ5?=
 =?utf-8?B?WFducDluSkYxVjVXekliZ2V3QTlEUUJiazdzVGttM3JTSnk4Zm4yZW9lRGg2?=
 =?utf-8?B?c0V1d2lRSUszWnEvMk1FRER0ZWhoNlRjSyswOEh2QnhFbjJiYy9yVU9VMjBM?=
 =?utf-8?B?S3dCSU1RS01TbEJ2eEhQS3hGLzVwazdtNThLNzFRUGxOaFU0TlAvSFJUeEdI?=
 =?utf-8?B?Q3BtM1RwZVFEQXVTY1JiK2VXZnpzaUwrRS85OTBNN0NXeHM1d2ZWYzBDNGVz?=
 =?utf-8?B?VENkbFhuaEtRVlBJclR3cC9HQ1ZoNkJaOFNBK1BMeFRtd29ka0dpR1Y4NzQw?=
 =?utf-8?B?bTdsYmV3ZHFvWVdhNXhRcXJZangvdnBSZFhtaUxsNkZpQXJxZEE0Q2lRY2Iw?=
 =?utf-8?B?WW5senRibjhyaTJGNzZLY1NFQ2FrWVhQOGFRM3I2SmdLSHFERldHcXhVdTdm?=
 =?utf-8?B?bVN0Tk5pMGhaMktRM2JiNlgwQTFVOVZuWE5HajFNMjE1MmN5NW5pL3hEYzFj?=
 =?utf-8?B?bHNtblVQNmZ5eEtYaUExamJwbzlkbTNZdGxCZ2g3MmJUQXdMbnZyYTdpOFdm?=
 =?utf-8?B?RWx6SGRjNDg2ZzJBS1JXMkxJOTlRY3ovRkxXdTllMWs3b1dZMk5qOGVXTFMv?=
 =?utf-8?B?ZFlKSjdjUVdscUNlV2lrU1o1c1ZuQVhFOXJoaGNXTzMweW92aXlMNGNPZy9a?=
 =?utf-8?B?VmNMcWNhZUR2eitDUEVjRStWcmcrTEtCVytYRit0d0hsTkVXQXVTMk40b1py?=
 =?utf-8?B?NlVhNjY3NTVWRHJKOXNodStna3JhKzFyQ1RsMEJjSFplUHdGdHBib1JlMkha?=
 =?utf-8?B?RzRwUWFXYlgxS0FFSncrcS95d29FMElqT2hsNDdqSk93WDFQaDJLZWlnMTli?=
 =?utf-8?B?YVVYaHo0Qjl1OTFReHlnMjBSSHdjUTJjVDdrM2UxS1E5S3I3OE1mUk1sZGNw?=
 =?utf-8?B?OVZDRDRIZG5jZXhXaXZiZWZOL2ZFTllpUEpFaFFoV3U5MVBCSm9odGJpK1Q5?=
 =?utf-8?B?UWk4dlV3NXJJU1dTOWRaKzlGdHIyVmRzU2VyZjA0TWtka25pcWw1NGo1Njgw?=
 =?utf-8?B?SHRaMWxOaDFKZEtycThlbnRwN0hVRDl2NGt1cmorV2s1eHdMaDZTNE1pWDVP?=
 =?utf-8?B?TTA5cXlBZ2RUQVErclplUlBSTkFxKy9JR0ZVTk1oMllac2ZnTjRWYkdzUysy?=
 =?utf-8?B?WFZHeFJWcDhlazRoN2VzTlhJRkw0QnFCeTl6OG5nL29mRFp5d0h5MDk5VlZV?=
 =?utf-8?B?WVJKaDJ4RktLUmNWTE9TWkQxOThDczYwanZ4N2hXNlE2SjlXNTZGUktYWk1Q?=
 =?utf-8?B?Z0JmNytoOFp6dVJlQXhZNVlLTmw2RTllZkYrUjhWclNTazMzdDRwR1d6enc4?=
 =?utf-8?B?Q2V6dWlKaWk2bGFpTmZuY0cwL3JuU1RvdUZuTEdGTm5uRmZuT0NRYy9mUGdt?=
 =?utf-8?B?OWwwZ3ZreEUzOCtiVDd6T2dydUh6NVNiWnR1TEY0UlBDVGMxZlB0Q3Y0alRV?=
 =?utf-8?B?WTBWTFovMm5kSVpVSnVlZkIvMktRUDYveVVhVmFnWlVXZllaMmRPN2ZuSFh4?=
 =?utf-8?B?T3ZWTXVvUU1ybFlrWWlWVzE3b2VXRU9Qa3dpa1BBREpIdjJwcHkwa3dnTVhB?=
 =?utf-8?B?bm5YSEI1VUF0dU15ei9qeFg2dTEwR0JoNVp5RG1yWDRBTm82UUJzcVNmMkRn?=
 =?utf-8?B?UUNHanA4VTRzZjg1eHM3ekdBSWJHUCt1VW1uVWduUFBMajVST2xmUzh6NjR1?=
 =?utf-8?B?UFZtZnlpRklQTVdvK1ZoclM1TDFNQy9NZ2ZQVFZhRTJDTUNHZzNxSDBKWHR0?=
 =?utf-8?B?RXp5UkNXWlc0dkF4NFJFZDhLMVVDQ245QU1LNVhXTG5TTFY0alpCeitBK2ZF?=
 =?utf-8?B?bEluZmU4TkY0ZjBKendIeUZDeVNXUkdtbnpib05zbTFrUVFqNHRCOXlXZjhF?=
 =?utf-8?B?SnFoZGxvN2VIUkVKLzdaRWtzc1BzUXVjUlM1NDhVVi83dzVMNmZRYkpET1ZH?=
 =?utf-8?B?RzE0ZXdEcGgwcjN1NGpwMUZpWUllTlVqSVhXMktkNDVQeWhOeUY4MjJUV0ho?=
 =?utf-8?Q?fsAQ=3D?=
X-Microsoft-Antispam-Message-Info: YEK8PIFrvZ3ED8Od2vZjtbMnochUwY9GRwkW+woU6qbb6qVXbcdRrtnpkPI1alLlI9nShIREZUNtDmf6DLvrtNh/Arnj+xwgwsoqPPz3VdFpu+7c5RobuKx221i3u2KxSe6k6ooVCd1rN0VvjM2cyca8N54z4EUdUOezSV9hBFkjU/1FVFyLWySTGVSGaKhH
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;6:HbdzjS74rH9SYSWHsP1rrvShIrdCxEZ0JgvR2XnOoKsg6+0ILaB/x20FO/V0ZueDWgM4zJIjrBVrXUGvfcRLN2VtG2BVgUYOwWvxjNpKM30KZDXcryNIxZsXYTrR+t5DRt0DcduGpTJZnyU/baGQvN0eo7c5w05yoDEVUzWTR8DN6QVvAm+tKUXs6V6jD04KBLB/5bXsCkLpiAWj5UdSBdp+ppL3aHoX7ndS67jDTneyJZO9UHavgEfPWTPwtirksvWzm0mwn6xg+FSeX4623H/+4ul6H+Vb8JAG/A5imPLiPHk4Z19jjMqsGVNuPFV4h/cgY/h7hLRPKkd0Mj4kesQG8eFqtzYQ4jcy2lOiZbgLNUkHHEsViY61t5OjMuF1ervVRzKPGIO3jelY0aBvXPVzxeUc+SFgsQ5ErMtco0rA7yYrqrSa8YFy9d3tMEOndu+Kv32wGyysXlOnBrEVpg==;5:xbtCfkhY8Wv2mCnUSkhRdXnWwed3ocDwOq0g/OCisZ6HGM/ifXCW/2QA7VTFDbxnLGMHsXnvPPms4fW3p/712EFTC2RBshFTncdE2aYa3WfkDRRAci+OQ2oWef+YWzm5gOLPDWipNjL6NvjUERRG9yi3uENXDA7SVRTwVWK77O4=;24:4CHf9hYrHaXg6nwf/c6O/g1kQ5zVH8NhmnlksN+crufnUnVySyg5Pat7wa1ERzoiZh2PCcs3nzASqn2I8ZDKaSxIlC2pM0FkbdY1kyTpKFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;7:7yJnEgqilgY0e4MJkVBRFUlT2ri7XBzonoleToyTXJDd/8nh0BtNVASgfeI3jegLWxojJy9JhAyaJ2AT1RhLyrgVulWDlQRb2NA1S8NeNMvxdeeKX50CZ2L2ItuSqr0mMponbFViLA7D0qBtvr592EfwAiydRPhJsCO4ayXe06vO/+4CFmpwnS47UzVD8SojBkaTLEWv7EkyiGdGzHJaYia0A2s1BXiUR5PllEkw8EUvUBds4w3yv7bvINqFoPrj;20:KQRMh0CKOO+b9nSZKbe1qH1FoPbsc4XW+uhmRJZa2YzXwCTb0fX4gUkn9BxbiB+tH1WTZzyLX1g/au9bWJB5vqoL/e31Zmd0OWgL3VG/KT+8/mvPrFdmaqEY1vksoNJDluTfGTUmK8R1mkgi9pRpTIipnaxvpTjNCbLXa7p0jzmAiXxJO/igUQzWNcea9CXRjpJGS89695oos2O5+kDOx6out1zLC2x79eytUsa62Kf2cyRc/o1jWyeS9QW9H+l9
X-MS-Office365-Filtering-Correlation-Id: 349a4136-d347-48f5-871c-08d5a4789f02
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:33:49.8274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349a4136-d347-48f5-871c-08d5a4789f02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943307609478014?=
X-GMAIL-MSGID: =?utf-8?q?1598008051099225714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 17.04.2018 um 17:07 schrieb Andres Rodriguez:
>
>
> On 2018-04-17 04:48 AM, Christian König wrote:
>> Well this is a rather big NAK for this patch.
>>
>> Only a small fraction of the firmware files amdgpu uses are actually 
>> optional (the ones with the *_2.bin name). All other files are 
>> mandatory for correct driver operation.
>>
>> There is a fallback when actually no firmware files at all are found, 
>> in this case we at least try to get a picture on the screen so that 
>> the user gets a hint on what is wrong. But this path isn't tested 
>> well and breaks from time to time.
>>
>> So when you get a message like "Direct firmware load for * failed 
>> with error -2" even if it's one of the "*_2.bin" files that is a 
>> clear hint that you should update your firmware package.
>
> The amdgpu driver already provides clear messages when a required 
> firmware file is not found. After request_firmware() returns an error, 
> we will print:
> "{ip_name}: Failed to load firmware {fw_name}"
>
> When the firmware is optional, we won't print that message, and handle 
> the firmware load in an appropriate way (re-use _1 firmware for_2 etc.)
>
> Note that we care about informing the user *only* if the firmware was 
> not found. If the firmware ends up coming from the fallback loader, 
> but we do receive it, then we don't really care.

And that is exactly what I disagree on. Even when we used the fallback 
there should definitely be an error message that the real firmware 
wasn't found.

We should probably add a message that the fallback is used and remove 
the error message that the firmware couldn't be loaded.

Regards,
Christian.

>
> This is specially important since we don't print a success message on 
> firmware load. So if we hit the fallback loader, the user will see a 
> warning followed by silence, so it could cause confusion on whether 
> the firmware load succeed or not.
>
> These are my 2c in the matter.
>
> Regards,
> Andres
>
>
>>
>> Regards,
>> Christian.
>>
>> Am 17.04.2018 um 00:24 schrieb Andres Rodriguez:
>>> Currently, during the normal boot process the amdgpu driver will 
>>> produce
>>> spew like the following in dmesg:
>>> Direct firmware load for amdgpu/polaris10_mec_2.bin failed with 
>>> error -2
>>>
>>> This happens when amdgpu tries to load optional firmware files. So the
>>> error does not affect the startup sequence.
>>>
>>> This patch switches the amdgpu to use firmware_request_nowarn(), which
>>> will not produce the warnings mentioned above. Hopefully resulting in a
>>> cleaner bootup log.
>>>
>>> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 12 +++++------
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 32 
>>> +++++++++++++++---------------
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 12 +++++------
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      |  4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  2 +-
>>>   21 files changed, 51 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>> index 4466f3535e2d..6c950811c0a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>> @@ -811,7 +811,7 @@ static int amdgpu_cgs_get_firmware_info(struct 
>>> cgs_device *cgs_device,
>>>                   return -EINVAL;
>>>               }
>>> -            err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
>>> +            err = firmware_request_nowarn(&adev->pm.fw, fw_name, 
>>> adev->dev);
>>>               if (err) {
>>>                   DRM_ERROR("Failed to request firmware\n");
>>>                   return err;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index af1b879a9ee9..d6225619e69f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -696,7 +696,7 @@ bool amdgpu_device_need_post(struct 
>>> amdgpu_device *adev)
>>>           if (adev->asic_type == CHIP_FIJI) {
>>>               int err;
>>>               uint32_t fw_ver;
>>> -            err = request_firmware(&adev->pm.fw, 
>>> "amdgpu/fiji_smc.bin", adev->dev);
>>> +            err = firmware_request_nowarn(&adev->pm.fw, 
>>> "amdgpu/fiji_smc.bin", adev->dev);
>>>               /* force vPost if error occured */
>>>               if (err)
>>>                   return true;
>>> @@ -1133,7 +1133,7 @@ static int 
>>> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->firmware.gpu_info_fw, fw_name, 
>>> adev->dev);
>>> +    err = firmware_request_nowarn(&adev->firmware.gpu_info_fw, 
>>> fw_name, adev->dev);
>>>       if (err) {
>>>           dev_err(adev->dev,
>>>               "Failed to load gpu_info firmware \"%s\"\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>> index 30b5500dc152..0acd1f3d14c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>> @@ -196,7 +196,7 @@ enum AMDGPU_UCODE_STATUS {
>>>   struct amdgpu_firmware_info {
>>>       /* ucode ID */
>>>       enum AMDGPU_UCODE_ID ucode_id;
>>> -    /* request_firmware */
>>> +    /* firmware_request */
>>>       const struct firmware *fw;
>>>       /* starting mc address */
>>>       uint64_t mc_addr;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> index b2eae86bf906..4de018d45081 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -171,7 +171,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>> -    r = request_firmware(&adev->uvd.fw, fw_name, adev->dev);
>>> +    r = firmware_request_nowarn(&adev->uvd.fw, fw_name, adev->dev);
>>>       if (r) {
>>>           dev_err(adev->dev, "amdgpu_uvd: Can't load firmware 
>>> \"%s\"\n",
>>>               fw_name);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index d274ae535530..b6af824a2f44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -138,7 +138,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device 
>>> *adev, unsigned long size)
>>>           return -EINVAL;
>>>       }
>>> -    r = request_firmware(&adev->vce.fw, fw_name, adev->dev);
>>> +    r = firmware_request_nowarn(&adev->vce.fw, fw_name, adev->dev);
>>>       if (r) {
>>>           dev_err(adev->dev, "amdgpu_vce: Can't load firmware 
>>> \"%s\"\n",
>>>               fw_name);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 837962118dbc..bd650b87e281 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -67,7 +67,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>>           return -EINVAL;
>>>       }
>>> -    r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
>>> +    r = firmware_request_nowarn(&adev->vcn.fw, fw_name, adev->dev);
>>>       if (r) {
>>>           dev_err(adev->dev, "amdgpu_vcn: Can't load firmware 
>>> \"%s\"\n",
>>>               fw_name);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>> index a0943aa8d1d3..95e1edc1311d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>> @@ -5849,7 +5849,7 @@ static int ci_dpm_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->pm.fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> index 6e8278e689b1..93c8acca0360 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -135,7 +135,7 @@ static int cik_sdma_init_microcode(struct 
>>> amdgpu_device *adev)
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "radeon/%s_sdma.bin", chip_name);
>>>           else
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "radeon/%s_sdma1.bin", chip_name);
>>> -        err = request_firmware(&adev->sdma.instance[i].fw, fw_name, 
>>> adev->dev);
>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>> fw_name, adev->dev);
>>>           if (err)
>>>               goto out;
>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> index 9870d83b68c1..8aebab5edf15 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> @@ -335,7 +335,7 @@ static int gfx_v6_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>> @@ -346,7 +346,7 @@ static int gfx_v6_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.pfp_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>> @@ -357,7 +357,7 @@ static int gfx_v6_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.me_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>> @@ -368,7 +368,7 @@ static int gfx_v6_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.ce_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index a066c5eda135..35a0e46464a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -926,7 +926,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>> @@ -934,7 +934,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           goto out;
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>> @@ -942,7 +942,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           goto out;
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>> @@ -950,7 +950,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           goto out;
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.mec_fw);
>>> @@ -959,7 +959,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type == CHIP_KAVERI) {
>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec2.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>>           if (err)
>>>               goto out;
>>>           err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>> @@ -968,7 +968,7 @@ static int gfx_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index 4e694ae9f308..c16cd96a1557 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -936,14 +936,14 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>> CHIP_POLARIS12) {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>>           if (err == -ENOENT) {
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_pfp.bin", chip_name);
>>> -            err = request_firmware(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.pfp_fw, 
>>> fw_name, adev->dev);
>>>           }
>>>       } else {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>>       }
>>>       if (err)
>>>           goto out;
>>> @@ -956,14 +956,14 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>> CHIP_POLARIS12) {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>>           if (err == -ENOENT) {
>>>               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", 
>>> chip_name);
>>> -            err = request_firmware(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.me_fw, 
>>> fw_name, adev->dev);
>>>           }
>>>       } else {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>>       }
>>>       if (err)
>>>           goto out;
>>> @@ -977,14 +977,14 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>> CHIP_POLARIS12) {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>>           if (err == -ENOENT) {
>>>               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", 
>>> chip_name);
>>> -            err = request_firmware(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.ce_fw, 
>>> fw_name, adev->dev);
>>>           }
>>>       } else {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>>       }
>>>       if (err)
>>>           goto out;
>>> @@ -1007,7 +1007,7 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           adev->virt.chained_ib_support = false;
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>> @@ -1057,14 +1057,14 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>> CHIP_POLARIS12) {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>> adev->dev);
>>>           if (err == -ENOENT) {
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_mec.bin", chip_name);
>>> -            err = request_firmware(&adev->gfx.mec_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.mec_fw, 
>>> fw_name, adev->dev);
>>>           }
>>>       } else {
>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", 
>>> chip_name);
>>> -        err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>> +        err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>> adev->dev);
>>>       }
>>>       if (err)
>>>           goto out;
>>> @@ -1079,14 +1079,14 @@ static int gfx_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           (adev->asic_type != CHIP_TOPAZ)) {
>>>           if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type 
>>> <= CHIP_POLARIS12) {
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_mec2_2.bin", chip_name);
>>> -            err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>> fw_name, adev->dev);
>>>               if (err == -ENOENT) {
>>>                   snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_mec2.bin", chip_name);
>>> -                err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>> +                err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>> fw_name, adev->dev);
>>>               }
>>>           } else {
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_mec2.bin", chip_name);
>>> -            err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>> +            err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>> fw_name, adev->dev);
>>>           }
>>>           if (!err) {
>>>               err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index c06479615e8a..9f70012c81ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -370,7 +370,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>> @@ -381,7 +381,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.pfp_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>> @@ -392,7 +392,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.me_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>> @@ -403,7 +403,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       adev->gfx.ce_feature_version = 
>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>> @@ -449,7 +449,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->gfx.mec_fw);
>>> @@ -461,7 +461,7 @@ static int gfx_v9_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, 
>>> adev->dev);
>>>       if (!err) {
>>>           err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>>           if (err)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index 8e28270d1ea9..4192a5a0c444 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -136,7 +136,7 @@ static int gmc_v6_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>           snprintf(fw_name, sizeof(fw_name), "radeon/si58_mc.bin");
>>>       else
>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>       if (err)
>>>           goto out;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 86e9d682c59e..06deba7f707d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -151,7 +151,7 @@ static int gmc_v7_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       else
>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->mc.fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 9a813d834f1a..cbce96198dbc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -235,7 +235,7 @@ static int gmc_v8_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->mc.fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>> index 5a9fe24697f9..718722ef1835 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>> @@ -105,7 +105,7 @@ int psp_v10_0_init_microcode(struct psp_context 
>>> *psp)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c 
>>> b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>> index 19bd1934e63d..dd5261577d9b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>> @@ -111,7 +111,7 @@ int psp_v3_1_init_microcode(struct psp_context 
>>> *psp)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->psp.sos_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>> @@ -131,7 +131,7 @@ int psp_v3_1_init_microcode(struct psp_context 
>>> *psp)
>>>                   le32_to_cpu(hdr->sos_offset_bytes);
>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, 
>>> adev->dev);
>>>       if (err)
>>>           goto out;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> index d4787ad4d346..a2afbaacc7e5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -146,7 +146,7 @@ static int sdma_v2_4_init_microcode(struct 
>>> amdgpu_device *adev)
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma.bin", chip_name);
>>>           else
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma1.bin", chip_name);
>>> -        err = request_firmware(&adev->sdma.instance[i].fw, fw_name, 
>>> adev->dev);
>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>> fw_name, adev->dev);
>>>           if (err)
>>>               goto out;
>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> index 521978c40537..75d2a9cc9268 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -298,7 +298,7 @@ static int sdma_v3_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma.bin", chip_name);
>>>           else
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma1.bin", chip_name);
>>> -        err = request_firmware(&adev->sdma.instance[i].fw, fw_name, 
>>> adev->dev);
>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>> fw_name, adev->dev);
>>>           if (err)
>>>               goto out;
>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index 91cf95a8c39c..e1ebfb9e2650 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -176,7 +176,7 @@ static int sdma_v4_0_init_microcode(struct 
>>> amdgpu_device *adev)
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma.bin", chip_name);
>>>           else
>>>               snprintf(fw_name, sizeof(fw_name), 
>>> "amdgpu/%s_sdma1.bin", chip_name);
>>> -        err = request_firmware(&adev->sdma.instance[i].fw, fw_name, 
>>> adev->dev);
>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>> fw_name, adev->dev);
>>>           if (err)
>>>               goto out;
>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>> index ce675a7f179a..5538a5269417 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>> @@ -7687,7 +7687,7 @@ static int si_dpm_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       }
>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", 
>>> chip_name);
>>> -    err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
>>> +    err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>>>       if (err)
>>>           goto out;
>>>       err = amdgpu_ucode_validate(adev->pm.fw);
>>
