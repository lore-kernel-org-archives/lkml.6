Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeCEJUH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:20:07 -0500
Received: from mail-he1eur01on0116.outbound.protection.outlook.com ([104.47.0.116]:44096
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932672AbeCEJUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:20:00 -0500
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v2 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Steven Rostedt <rostedt@goodmis.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>
References: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
 <20180301164343.5794-3-alexander.sverdlin@nokia.com>
 <20180302120026.52f34ad2@vmware.local.home>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <8aa72633-5323-7f85-d326-6b7231b12aeb@nokia.com>
Date: Mon, 5 Mar 2018 10:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302120026.52f34ad2@vmware.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(438002)(51914003)(199004)(189003)(65806001)(65956001)(2906002)(47776003)(356003)(53546011)(36756003)(8936002)(186003)(97736004)(230700001)(478600001)(86362001)(31696002)(26826003)(305945005)(336012)(22756006)(54906003)(229853002)(106002)(4326008)(64126003)(68736007)(31686004)(2486003)(23676004)(6916009)(2950100002)(6246003)(81156014)(81166006)(26005)(8676002)(77096007)(76176011)(316002)(53936002)(5660300001)(58126008)(65826007)(106466001)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB0892;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT058;1:rk3GUvIuxBI5X3FBSCFWrypGWrPpEUBca+/m7Wtby3hwViBb9feSYog3ljSfkvckWgM1U8KGsY40hpqBMxYplE4Phbpx4m57JWERqV832vTBEqFSgQf2sLHYN6D5Njva
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38afde66-03d0-4077-147a-08d5827a4303
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307);SRVR:HE1PR07MB0892;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB0892;3:zJE0JiPHkgoWlFhan+bNBwCOVq010kJuXAb5v3OL2Ge7+D09uAL1gajoNrE7KWdw9os7GcyFuLBJzEz+eY0CdbXFmaC+QRxJYQLg/mDOXJDFvQAwCImImejkpCLVAzAcudE6GYC6oGsw2EmLlsYk0YARIqHTqecB1GW2W1anOp6VNVtsoQSnIBlGUsNJ9DBgZomtMPpd9SOaJVPg73zIIGFuwMdAOQpo/eEU2aJylBKkI0iqayO3I58lMaIeiTAAtZmMt9GNrQqSauhUj5+IH5iIuF+RbiZEph6UDG0PDo1Td4bjOX3UU3HjTwoYY18WeauLoSp4an/tysIqkAMgh8hOVUJXvqJ0EC0iw1CG4Cc=;25:fMZ5xroFRaDKA7OKTKLKLwfwu9ea3Wwb5wiLJhy5MCjXUptSA8bcMw9wVTXKIPnPAY780ea/HBuq1OLz0utamjsfbXiW00VZnn+BVpQd9gvYgNwjGingoZ9GrFdXGmmMGdS7TmrlJl450SOVPICGm2AsbIC3ulXSPsKyE0tBV0s0kO4sn9FJ1Js+L32Rtx1v5bdiw96oZEv0uVupngCpzSyNZVI8x0eqCM+2HS0nh6Y9xpwxcgKCB1FTVcuo5t4pZqkir/R54Qftn0lTr8S/lHP2vmwcV0Ah48Fvps7oT8HZ0tPqr9mxkn/TNRbs0sN2Y9hTyBuj6BlLm9C+e0+FZA==
X-MS-TrafficTypeDiagnostic: HE1PR07MB0892:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB0892;31:Y+0x4yPUZqd3CtIEkaCgdVDpN1nU9J1lhWRoo11v7SrX/bIISBXtayLs+W7QWgoIgUIUZDS+maNGijunTGRq+d58Q+6+WKW4Rb2wEODiXgq/hBCvZfmvZHkuVxR5ftgGy/KeSS3VBO4vd0GTIJgl8Ea5uRx2P19oJMPPFCVVPpBSxtHbYfchSDIbkN0FHbeNITzyIpfPYctmrcgMeK1kzInCIfrWgmRaRsaI/k8UmdM=;20:FpcpjGKgd3DK/M7xHH/qOLEZPTHALr6nEgCG4B8I8H9Gjb5jR5ucMG9IxXfSL5resZn8AWHFx2CLRoObTjGXmx5ib67Av75NE5gECUjTV7SaqGw8VgE9Pjs0bv7IOmbiX8LwbLOFK9AFyzP/K8RRg2FXiBuncBBVWUTGht3w4Mzd8FYwKNOLu3SVttxBAl8wKtjPNLKOh8tTCUefh6UVVzcOre0l9e1HzJ35FGZwL58QrmrI8mrnEyeMX5kukQ49d3s7MTqNQGXX5r5FlZgUKE/EZwwNR43mgB5jGZlkGFM1NQ+JK/S7jsQei0ffKomIcLfmCm4Btu2G9ASJEoozcVSVn43B44Wgobo/KmBARXB1fkPOaM0GsXcgj/AXPE3QDNNWoolkm86Pv4ayxIl43jkTEIyLOTxpkL4euh2o1t3hM4k01lXxzR7xqKkR635u7d6o+YEWhZL3EZCV1WqREhcqhhXKGReH9CSaXmyxQaFBwo4fdJ8k3lf3lChX47RZunVfQNjv90Pn27TlYVAvFU7vWSNjH3z8eBRFWfcjnCIEW+XvaBqH/coGznM29RlHWazgeUinr2Xy8Y1+6BMCGzxGs451p94EtGL6m7wJQvQ=
X-Microsoft-Antispam-PRVS: <HE1PR07MB08922E0A41A3CD576F213E3088DA0@HE1PR07MB0892.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231220)(11241501184)(806099)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR07MB0892;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB0892;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB0892;4:/oGU/13CUOZyea4ek4qQ5tdsY24XnPN5RaFWWcxOXIsAnmBZj6ldLi8atlcGSnoAl0tHme+1L01CYjvzWiQx6+sNlbknum/8mQiHEEkJ9Podfi/Wvs2fsxwECYLmf102Ttxm/fco1rawQ3iz6+RyMKqibdiTXnSxlCDP1Nx71xBCJJq/c7+WnJYa9+65sQNE9MRltnt+x4U3YRUfbot+xcYbKuMMeBkBldMuIe/mKMeC2GEdXjq9BIfYH3S6m+MNp5aVr9FL7cpb2zbz1VCNgA==
X-Forefront-PRVS: 06022AA85F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3TUIwODkyOzIzOmZoNUdyUnY2TTQ3YzVNcVphNU5TdWI1OWdX?=
 =?utf-8?B?V0hPelJiVHd4YmQwdlNROExYbmJSQ1B6dzU3bjMxam9wekdka1FvbzVvTERE?=
 =?utf-8?B?WHZvVGkxeU9vc001VHZpdUFXRjR5Y2ZDVG9WQlNRckZYUnd2NHRHZG5XbUZY?=
 =?utf-8?B?K3V6VVpiM1ZEUXBSV0dIeHltY3VJdVBhd3ZLSlFQOEdMaGZzck9iYnlBMjMx?=
 =?utf-8?B?NnRtRFowREpyVVcxOThobWd6Y0hTaXkvWEdoSUdNcVlXT2F0eVVrUmpHUGtD?=
 =?utf-8?B?YWlMY0wxTGx0ZWlFNVl2eEUzVHJLci9ZaXFSeGtJakVvS0hUMW1jelZRV0lm?=
 =?utf-8?B?MjUrUlJ6VTloOUlGMHpBWVQra0JqK1A0NkN6UXorWE5MOWVCcHNtZDc2NGtS?=
 =?utf-8?B?TTh5aDhCUFRScHpjSFZmV2hoWlZzK29qQ0Zacm5yOU1aMzNNUXlrMDgyWjU0?=
 =?utf-8?B?MEVTNjlCeVMvNlp5SU9aTzZiR3I5TmtQVDRkSDhvQmJKeHYrN2MvUGxHSm5X?=
 =?utf-8?B?bUQ1MHhKbzFnQ0JDbXk2V3BnWWhkejhCd1ZRSmlsV1c3SkF1SSs1TmJHY2l0?=
 =?utf-8?B?WVYzLzJyNGNqc1U0a29PZFZGdk1kZFUvVGJ5ZTNuRGVRaUlBWDVDMkN6a3lt?=
 =?utf-8?B?RTE2TXN5WEo1OS95cVpUcnVYMlNyRExQd1FsMzNkeTZNSWZTRFpad3FtODZ4?=
 =?utf-8?B?UlAxb0d4cFdRT0RDeVllMTkzeDNKclQxeTJNMzUyUGVqc3JtU0lTelk1N0NO?=
 =?utf-8?B?NU5BTWs4R214c2MrNkluTFZVSkorM1FlRDgzendDSEhmZGUxQklxbmp5Q2hN?=
 =?utf-8?B?SlpnTmlCc2xMcmpwSTZnTy9KWWlOY3JlK3duRmhSSHFSdWY2L0J1ZjVBR1A3?=
 =?utf-8?B?UFZ1eWkyQm5iS1JibzBWRmZic3V5aVFHSXF5bHNiNmJSZGsxY29kRElGNTRL?=
 =?utf-8?B?MjRtU2dydE1uZkF5SHJMbFFQbFc0RXpXdTJpR2FGcWxpMXhKWjlRdndlell6?=
 =?utf-8?B?V2cxQWc4UlZaSzl6VW5HaUdaUS9aQ3VIWXFvbEFrampHVGl2NDVEaGZadWl0?=
 =?utf-8?B?U0tJQ0Nqc2pvUGhGeVJhSUMxbWdWdk5WYUJTMUNLd1ZDUTR4bnZwMzh1Qjll?=
 =?utf-8?B?UTVsa2p0N2hoZWZ3ci8weWJEVjV2eXVLNFVtTXF5d0dDVDRqalBNNnVOdnBv?=
 =?utf-8?B?Q1Q0RmduOGkySjNhNWtSaEZuMzJxeFlNVnBMb2cyMUpKd3BRaGlnUkcyMUF4?=
 =?utf-8?B?S3ljdlgzWHljNFdVNW1GeXNHd2NVZkw1K1lUY0lEVnRqOEdMNXFtTUk2ZG9h?=
 =?utf-8?B?bTRBdStsYjlQTFpSN2hrMWhheXB1Z2VuUWdGMElNelB3dzNuOXBUbHRLNFZo?=
 =?utf-8?B?d3pxWjl6N1RNcllXakVTUDlaMk45TlZJR055NmM4QytTald4dDBYbjY1M3Bk?=
 =?utf-8?B?WTFKYXdrdGt1TERPYkdPRDVKZnp4NlJjZW02ZWJybUFTbTdzU2pyeStrQ2dR?=
 =?utf-8?B?RkZmei80cWRyTmVtVnlVRlA5RnJPQmdtMldmdmtSNyszQWllcnp2RnhvdG5I?=
 =?utf-8?B?dGZ3aXpYNXRjaEV2YXAwOEZYUmJqeE0yNU1rSG1wSzlpNnI0UldaTkdSMlJp?=
 =?utf-8?B?Myt2V1UyZFVTQlNPVXBUQzJyVi9PajQyVDc2MVBpVGpUUk1HMzk2eFp3PT0=?=
X-Microsoft-Antispam-Message-Info: mMASmsDM4l8fa8wflUmEFLrUMaulvOemZwIE3ZXTaUrPIJdeoP+LpXIdPFvuLty/ORPaI3JJy2Odv1iKUSX67Dw4dhYcEbviMrS00O/VWB+c0zsymkvnX6rVbZwz02Cq72uYmH2o6dne2QwwpO8UdxLHgOEXOf3YvzWbc/S6MG30uoYmnLYXDckyhpshkNHz4HnkxosVIUtptq/1m55u6Oq1xnxSuSTXDhrBRLWazOelcAUCDNWniVNqG+m9ISgphcFjblWjp2W2O0LqtDaJM2dFawW39b6aMkcz9gQn2zXAEOBox/gjbIxoA3EojhM0IOAB0QMu2D23LuJNXzfYA4JPAMGZqHVQDSM8Xu/nQgW6HRBdjddaQq64LrvNpmdk
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB0892;6:29tS+ltN01Ktn2rLAyW4DcKiQ6jlgLyJDaqlvtog23oZxy8rPaC8VHCIWEnKTHz20j7Da9EoU+x0OguzEyb7gkNpZcWob7VVzwYnNbAgrHVwZxGvlZapxRFogmZ9mOMiVZtodKctDe6dB3tRViNMwjgIEczWl53HxwwIaJRXDrtlH0iEeqahTOvnULOp2K0zbk/F5gSf3IZO/990YxUzf8MzAELJ/1X/VEHWr8HxqZLgWL0/eTAocLTfIlmrljobjAibOSBHqt/gNWgBgvimt4fMrWqQ468DS8N5KHAFC5EDcpxfSGbJpEA0g3aFwG44KYr5KzzUFBivASE6r8oE3AHwGmEg3g35LeczaHCdro5HIUrV+uo1SWBNBXUuuYUJU5VLOxy+nMfE+RYEWGFL+w==;5:E6n+arKHBdmgS4WzZ1UtDyhpCL9FHQFZSYM//n2DivshGVeM/haa9pdaQoLL2D5IUKq/VxRKSOKFj/OrEdV5SNa9+5at5Y218m5IKq/04Xf7oARkUT3494y4UB3yRlJo+Hp533L/4ScMSdQTf7q/vaNWueW4+c6oF3uxReIdcvU=;24:F43PfmIw/XLM4p1QIsFA5qdsyBNco1Ezg+IMAK62uWD0DmNA9GmeQmRsNFbmkURZPvmBeUpqICvlAiufQ9mU2QPKI6FM5YWQDtxaqJ9EaOI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB0892;7:YMsqQGx2PiJXQGz1h092bzcz5COxgUh2df4UCkKvQx6kA8E+FjpeOUgAcGLxoAcDLP/d+Wtv4PS0tBqavOjXxpO+StygU9Sf46Vu36m0EuZDEfKRSWE3fuqJUvHQCE+2UREKWKDsUA2b67qLHeFewUWAlV++i/eOQ2rCXq8cEdq9H4tibv5wAsxQkhWHOz249UX4CSpRUo1jRUWXiExuEaaWay7BRbjBbXSDn4EMxmpndQJsmxiStK3SYeTT1a/0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 09:19:54.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38afde66-03d0-4077-147a-08d5827a4303
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB0892
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven!

On 02/03/18 18:00, Steven Rostedt wrote:
>> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
>> index 9e842ff..3e663f9 100644
>> --- a/arch/arm/include/asm/ftrace.h
>> +++ b/arch/arm/include/asm/ftrace.h
>> @@ -19,6 +19,7 @@ struct dyn_arch_ftrace {
>>  #ifdef CONFIG_OLD_MCOUNT
>>  	bool	old_mcount;
>>  #endif
> I think you want to add:
> 
> #ifdef CONFIG_ARM_MODULE_PLTS
>> +	struct module *mod;
> #endif
> 
> This will add more memory overhead, and we don't want to add that if it
> is not needed.

Will include it into the next version.
Thanks for the review!

-- 
Best regards,
Alexander Sverdlin.
