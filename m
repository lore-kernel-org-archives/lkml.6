Return-Path: <aaro.koskinen@nokia.com>
X-Google-Smtp-Source: AIpwx497jkgPGshyeIOSoSQJodVjcyrPNXF6xzBbjkZ2MvT8+gpKw+Mzxsc3XRcaC+JcX+300PTY
ARC-Seal: i=1; a=rsa-sha256; t=1524480766; cv=none;
        d=google.com; s=arc-20160816;
        b=bKblx26PAcDJ86bNUtE0uaRHYfpPms7M6ul4xfi/Sxbhl/82dR3rb09E/cSCXXEJDO
         NdnkLxllNJJuneqCrX5Gv1O+2dKAQ/dS9jfj0+nYaNHFUJ7RrCiD+ddbUC5EfTzvmXX4
         1t859t5RdMzx7NoQVtyfCL1Phlow/MiiB9Z21asKCRINJ7wPNWDg+q7mk+PAMV1neZSO
         akBEwKmTICB9juMc5ixjm+BkRCabsTKCQHsxqiaol7APXUkXC5nlV7DUmRj4iPcAUe1c
         ENgCthQiHhivGASAXjigbsfD2T8u5PYPYAHBkgVQ0pXk/pYFYxapHFR1FM3rKcO0xR2r
         i38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=qXWT4NfVmjXKk8PbvEwWTMOPJTFx/O1GVuf4Kn5pzuc=;
        b=011gOxpXul6wI6qnyP/d6yoZD3Kt6BgzyJYr4aA9oiRWlfJA0fI7TdNKBIlQZ6qo+q
         hKuglE5G5Bn9dDdjrU9LD3drzJdc1BvGiJ4o5SBy25Ir2C3R4kPJj60liAzNSM595ejS
         EPVrA0ydiFPtMV7rMgjn4xM0pt2rFdXkqLhG4Ay8ss+bJZAP/gWvFKlYkkEXpgw2+/Xr
         AnpXBA79lL36qiJg4Btgp5F8hajiWlqORMtcsDUkiSrz7KlhtikDbjXyRWln0r70oi0Y
         OqPkASOIDw6sPXWXfwCrvIV0ZQ0lLUR1UXtcWhgAGC8A5z2K0KNe52eVeNcBXhkS/K55
         QEhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=URgPQMbT;
       spf=pass (google.com: domain of aaro.koskinen@nokia.com designates 104.47.0.116 as permitted sender) smtp.mailfrom=aaro.koskinen@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=URgPQMbT;
       spf=pass (google.com: domain of aaro.koskinen@nokia.com designates 104.47.0.116 as permitted sender) smtp.mailfrom=aaro.koskinen@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
X-HPESVCS-Source-Ip: 10.145.164.233
Date: Mon, 23 Apr 2018 13:51:38 +0300
From: Aaro Koskinen <aaro.koskinen@nokia.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mceier@gmail.com>,
	<aarcange@redhat.com>, <luto@kernel.org>, <arjan@linux.intel.com>,
	<bp@alien8.de>, <dan.j.williams@intel.com>, <dwmw2@infradead.org>,
	<gregkh@linuxfoundation.org>, <hughd@google.com>, <jpoimboe@redhat.com>,
	<jgross@suse.com>, <keescook@google.com>, <torvalds@linux-foundation.org>,
	<namit@vmware.com>, <peterz@infradead.org>, <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] x86, pti: fix boot warning from Global-bit setting
Message-ID: <20180423105138.GB16237@ak-laptop.emea.nsn-net.net>
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
 <20180420222021.1C7D2B3F@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180420222021.1C7D2B3F@viggo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(396003)(2980300002)(438002)(3190300001)(377424004)(199004)(189003)(9170700003)(53936002)(356003)(6346003)(23726003)(1076002)(229853002)(44832011)(8936002)(22756006)(77096007)(46406003)(2906002)(47776003)(33656002)(26005)(478600001)(50466002)(6246003)(186003)(8676002)(6916009)(55016002)(4326008)(86362001)(336012)(81166006)(106466001)(305945005)(106002)(7696005)(16586007)(7416002)(58126008)(5660300001)(316002)(54906003)(97756001)(59450400001)(9686003)(126002)(486006)(446003)(11346002)(476003)(39060400002)(76176011)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4399;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT003;1:ZG8cywAs9tlrK/tPfsoTbN4L/B5bXStTReL8jkir2CaQt+GdUswmtIiPCAXWokTx8bymzj9hoy3u58WuAe8Y9Uy8A0mwE92MPaBEnWO3FIUIiii4dKngw/PZ1qzwMaSW
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:VI1PR07MB4399;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB4399;3:24ojXauOK565Su1mOu/yUX1IpDKfjDZgiH8OmO0x6cM4DhJNxjkhZfIj5of0Rro7FugS56w9iSrYcqKeKSrsH1Fd/y6bJHaF+w0m5RRPrdCroYx8knIXo/Rtw0vH2zb5Hd41NXy9EsRj545pTwnujKZo/ykpU1AbHa7PAwUOQ44CPrjdsgJYVpFgU/uRxXIT7hjdre8G1qrCdPcoDkbMX2AKoxjnP03ezOCg91QXFxj8sWXHA4UybDYkZJUAVTlRf4tfIvQFKvP6xXdIbmsNkoajHkSKFjxRqfrupfrdR58BXUsmf4Jr0mZfh979mCn6mipHRiSLA1EKjEVXhE+KsLzl4PVPWBaBPM9H4XvX4nQ=;25:HSaS/fAaKS/r+RdKL6heuKzEJ3knDIhnycZPhG8aYu9/6aaD4RKlt7lXfRaa+0/S+41ZX3dCvaYqUhrCFzwIzMysFRazW5p1+m1dIS9iyCzjEdXYmAqUoaoaEbDbLk+hMXpTwUnrlHJ0G9/dBx25Evqnc0TD3g2IbzpHJe4PM3waDKorfMCPiGr2cx4leVe6jDwJ6qODwNUy5Z+3mrG/pgWnjsf2+uyAVXt/Hbj7KO37Q37NT6+NrAc8kZTTVShLV15Jv4S0K1l9fM3FaIKH1WEGIUXx+23p3ZMdJh6qH6ZuVT1WG89UAdiVY2+LIkHOyVCVbtPLUA7bjg0SezTbnA==
X-MS-TrafficTypeDiagnostic: VI1PR07MB4399:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB4399;31:K2JastOHvY1Hl5Jd4I4c4WnSih5KlR9ZdJjwUUiS/RCmqXCrVQlDfNtqreh/v2jq2p4LIzGlx7o9qq9htpHcDXO3LDHGN0LxzT0geddWxzNhFXfNQStqF3SuSjfy9FYCArIzSGyytzFWh745YmRpGiSSifh/I9aHZY30e1A4/cS9hOcgI4jyoVNiwIam7ZOnUB6GfTqIr7HTsLNz7G1TsRI7oXroWrpeVSIILCnjlpM=;20:0SiLAZzpuP0+2WOuw1GyKJNibYmsTGmMxCZa1qq6PJFpjE+kSsbPtiF/cpLFMol9UMPUDoEUg+NtZpcBALodXXceDaH5QzolWCM/w8x5m5+qoXAAKiO3wDozRaUOHfiayA2envu2UqZ6nkn1OwItBj0mUnZJLe+clE3uR+zwoYYNm1ivgKOHsx81LOfRyBT+HzPjsymfEK2rnobbFi8nNkdCU1Z3U3e3RgWNOBZKXchdcDaT/Id34a5exFo0uI6Y2KpqgBveAXE88h5UjR6IFtM5Bvyyd8Z9l3PySQF0VRZO5uOeSNCWtOOc1jU230COxgVsohbBw49SsVRXDVsQIL1msKLh01SNn3qTlodZmTQJWWX7XDkES1a3fqUs708/I2HNIUUJOT0KALxE6irD8A91LGpIu2lasdRuuEX7rm/UbQmJVYO53L7oBLqicyv1vwCi+zCUQpFtxbYagwYamolPfPoLVihM84rQHlWRkD0ah7fby3Tfoj/hSmicFizR3bPO/uYOd5b0qotbJNQzCMnL50OqQPECP9zjMXh+2kccuCwq3hLtPwZeHH7IrDdNL2Ql4tB0WQEzVo+iOwXE5IEudz3NHg59DBUjj9zZBso=
X-Microsoft-Antispam-PRVS: <VI1PR07MB4399A967145222C1D358ACB3F4890@VI1PR07MB4399.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(82608151540597)(85827821059158)(211936372134217)(153496737603132)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(11241501184)(806099)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB4399;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB4399;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB4399;4:pWQnznMzUKpW3uymXT4gUCEWuAgA3xvdcEV1fm1Qj3ISod/WURegEdSKm2HA+LUK2GXRD5hfIFnMVOJu5yD7qJOK/Ma2kOVE/BzG5H8F3gko7LcZmAsQhuIHdQBdTkfofh++0J7qYh0BapRzTr4Wob1Bi4GGAFRwNxmYx4hGKfbq5PcIgLU6MmklyibFMaaNyZeOm3i1SDMO88nTTXfZ1uIh5XKQtq6N0jDqOGnwu5jk8qduVcxyoTslZhol/2UnDqnp/10T8zLU3fECVYtQjvpEJKAcoixWpXPOsiyQBLLgBfcZNS4/EBK7M8UKJ+/RHwau7XR98im4GrkX6bqxeSmdQksykqsH6Dmo+kBKcNuMOV57I9KJYb9vmm9YlFojYDN/WYwhEm7Wfz5Sf/5YOQ2medc9Zxq1sody5X1l/7ZsGkpeixZTWwT3n2RDMMd0jsC7JYK61VMV04PFiW58wz6nRUFwgeIz5nlQW5vIuEM=
X-Forefront-PRVS: 06515DA04B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB4399;23:PpqL76yqXluf9cs7vTRjwSnAj/BadzSaUy+/3b4bq?=
 =?us-ascii?Q?b4oZ5G94s0J+5rDl5nST2C0xfaRildSlkBZmeQPj9U2sDZNU1JjN33LzGm5O?=
 =?us-ascii?Q?34MdJ2ESleKMcy1MSEoEfOJHKbQdC0Ej8uQt0qr5eWPov6hcCaT1FpILYkP0?=
 =?us-ascii?Q?4N+hJg0e0Yr0fUg1T/N8u2bRo0nzmEMbZsZ30tvDptz1ngEmMCru4jjC1QNE?=
 =?us-ascii?Q?YkyP3skz3h1K3+tWjc0j+/xVy6uhiURGYZt+eBmteb1zobYuF2JwA/nFWEwl?=
 =?us-ascii?Q?bumC43iBodwI8wUrkoheLCzHvVsCrY9lhqRhTfv8q7UUN+9A7k2c+sS+0zC3?=
 =?us-ascii?Q?ta+JAUr1B7+2oMldGpfTA3AnYIauak4d7howLW0/dilUHsCWT5m1M9fRaweh?=
 =?us-ascii?Q?1wEMEnQEdXOkBsojZC1BBHnhgMGbNOEwEjEWSISHmItOre6U9fZuGUtbbbH7?=
 =?us-ascii?Q?Qv0Ab5W8JsRTRfYviCQmGIcEuFYPXqDTWqH1QaX5FIjlU5so+3OvdNC5pw+4?=
 =?us-ascii?Q?EMt0aOH5MEof64aAOPVTWQmm+mVp+aQUATCchlbYyNyKsJDgwwUDU35cS5v5?=
 =?us-ascii?Q?ajDUquIp+HmhXpozHe4KeeAkewF4GMmZZrji8+2DN9VrOe2KFcEW9XqzsFoK?=
 =?us-ascii?Q?7ScDTvZwSORwpxCB4HIuBjyC79sJ8w6EZYwlNoDjOMOoMxHzyuaLFUskAuNy?=
 =?us-ascii?Q?OrzfMChLw1rnCB2c8FkTGzrqG8ydM5J4yUIae2YaduTiucri5NEuFsvy7z7V?=
 =?us-ascii?Q?yxqkPfpbz4sakUKd654cmxWbSQqx9QLiV5Oo7LaaxIsxXP3Nuak3rY2mSKJU?=
 =?us-ascii?Q?f79R8rKf5rHn46860qsmLcIC3v0haE6ttoywmvIkkFPWyi5GydtUAGg2Flcm?=
 =?us-ascii?Q?B+CfZDhjYqvJqCo8hw96EYjPeeRyR1rYq8VmtCUc55l4qhslarmwiD+7yyHF?=
 =?us-ascii?Q?Z6y33n9QW1vUbZWBh3kRmzAAA0nB1tUjepC5Vj6lGdb9yrBhTsGIQkbjFiff?=
 =?us-ascii?Q?xVyCil9gyr0p+ha6mGaFCw785sLvB42HIXi7f7smcfyfaYfChRVSck+3P4sb?=
 =?us-ascii?Q?U4cRRI+qFmdNeyFVkUcfuaDBqWAKKbDsJEqjWd3ZyEsqZX4iLnTGY2N9FewE?=
 =?us-ascii?Q?OGpMqBapFuALH32a8rCsX2OMiVI3eAHW2iDNhs5XZS5S8a8kH1YdwMzMwvcx?=
 =?us-ascii?Q?ayF91lpf7JaFLgUYhh7z+kC6+hSU7rTEcxjHnFaljVFqLKhX/rNANt7YXAv+?=
 =?us-ascii?Q?XPiztq7pO2XH2+7lRH0dvi+cSyuw/zd7tOxF5quVerhSAIHedMCp97edmhIM?=
 =?us-ascii?Q?qbtRySFW25AZDYBGiDvgs0KHmBVjuERB23ldWlHuaf1?=
X-Microsoft-Antispam-Message-Info: WRrxLRraC3/XtaCrna/I50Z1TarKc1q/7aVUAtCwXtnIxY9u5I4D79SxkQNVPkQnNp0PYcqypPCpdznsF/lt4Rw4eonbLoBtvGtYuVeK5iEyR6lONpI3dYqctp0rVg2iPs03G2FW43mSWxPkf5QPfPKTwWM6s6IYj3wqeGHwe07x34vIlmruzWuVqDryLw2X9nVx97hYTweiF9YBd/9kAEALY3lDkMdDuDUABCATOUPgh58RdrFqU/n8E4vWwt4UWrhfoZCRvsmLIYPKKx0M4h3CreaZOU4myIvPi2r4avE7clYldhqfwUBEc9TDkOHDSM2AAdG2GsfySJdJzFQ30FfyczCvtQB4GoPt9OVqnTgWgxWJk9zEg3ufkZT9GqeoCVVtSV0c17p4WuYpomOe3uLikCG5wwTPd05NdcXGHPZET6qggSWi6OES4xuYYygM95xOkiZzw4UO0VByY0ks8g==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB4399;6:7E2G8Ap+3b/F6gfoKfmGzLyGop6WNmNB6nn3KulQijB9jMd9n6iiTSOyS99fR6X8wZSzMRx5EDVVjETMrQxLJRxomfsqFi18cdIXOzjNM2rBJa8xihvgHuOGk/JYu2UpclVPQuyjzlIL8YXDg+xFDheslgLjp4+3WxOkEeD/sXoHclS7g74qqJs0eGOeNwiCwYzvBXqmlo9NuMK8XC7ihtHX2QJjly9AOQmcuSbFgcpbaNZrnYAb7gnnbXvNpox4tTpcchmqJCuZ/XUYpU2E37FFd5CtHs1BFrbZCbf2PrsiXIEGl+OI8K9K/r0cFMwj8VA5rqgOBZooXgCGF6jVeEiZF/T+92e+/NOlsaym48T9sHHi0vWWMPVVdiQQSMVa66R1IUX8cBf7jINRdaX5YlXw8cjeJnTbHmPbdN0zl1oJswsJZpT6jaAiVp8wpjt6ko+mCatl9YBnu54Xm6Bn2Nwdvv/pC1lVgVAI6TQ8W0Jz9Hv4RSLpQCK8d5kP1KY0;5:qWo9NOqO2fEqdHfG/ps1DbkFoLI6V8WLYqQUDSjGWY2VRKZ9++Cd9Xk/oL3J5IuE5R6Gs3hhWb379+PNpDyVT4ojMGw4RkF7jThBb/yjxv84amNJrPvn5efqZQS2nKWkvxZcZUz2j2onef577dW8kpRf9RjraSxFOhHuJ4k4X7w=;24:YW8+6xbNsGAGPO/kZTpAThturtnPiJWMdlrdEs88PdP5khV08ASu+Zd5/pkYdZ5cFS9l6W7u+BiOmPcBj3xtwvMtTH+BeS8npM2ja8MtJSE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB4399;7:bhdq2SmrtK5zu/xesovbpPsxBt4l+ZbvUcvJdXEBYI4vcB2U7a878Nu7K1shh9b0Xby9EHMQy1AtS26IBO6av2o9ZSg/TpglSqWPS42c5X5qWKCZRRm4tUkJmM3uC5mAr7uS+BtRNTXEEvY3Swy8Nwgumieil0mng9cBPZM82t/DPLn/cCBoetd00PS6NvKD7qnNUMjf+R2TVgJiT0kQaIdDF7P6JJL0A6Snzoru1NNg1h2h3QpNsyAVcgjjzxEC
X-MS-Office365-Filtering-Correlation-Id: 550aa074-def2-42e8-6bac-08d5a908555a
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 10:52:39.5083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550aa074-def2-42e8-6bac-08d5a908555a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4399
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029619129049046?=
X-GMAIL-MSGID: =?utf-8?q?1598533944709935293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Apr 20, 2018 at 03:20:21PM -0700, Dave Hansen wrote:
> The pageattr.c code attempts to process "faults" when it goes looking
> for PTEs to change and finds non-present entries.  It allows these
> faults in the linear map which is "expected to have holes", but
> WARN()s about them elsewhere, like when called on the kernel image.
> 
> However, we are now calling change_page_attr_clear() on the kernel
> image in the process of trying to clear the Global bit.
> 
> This trips the warning in __cpa_process_fault() if a non-present PTE is
> encountered in the kernel image.  The "holes" in the kernel image
> result from free_init_pages()'s use of set_memory_np().  These holes
> are totally fine, and result from normal operation, just as they would
> be in the kernel linear map.
> 
> Just silence the warning when holes in the kernel image are encountered.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
> Reported-by: Mariusz Ceier <mceier@gmail.com>
> Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

A.

> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mm@kvack.org
> ---
> 
>  b/arch/x86/mm/pageattr.c |   41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff -puN arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr arch/x86/mm/pageattr.c
> --- a/arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr	2018-04-20 14:10:01.619749168 -0700
> +++ b/arch/x86/mm/pageattr.c	2018-04-20 14:10:01.623749168 -0700
> @@ -93,6 +93,18 @@ void arch_report_meminfo(struct seq_file
>  static inline void split_page_count(int level) { }
>  #endif
>  
> +static inline int
> +within(unsigned long addr, unsigned long start, unsigned long end)
> +{
> +	return addr >= start && addr < end;
> +}
> +
> +static inline int
> +within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
> +{
> +	return addr >= start && addr <= end;
> +}
> +
>  #ifdef CONFIG_X86_64
>  
>  static inline unsigned long highmap_start_pfn(void)
> @@ -106,20 +118,26 @@ static inline unsigned long highmap_end_
>  	return __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1) >> PAGE_SHIFT;
>  }
>  
> -#endif
> -
> -static inline int
> -within(unsigned long addr, unsigned long start, unsigned long end)
> +static bool __cpa_pfn_in_highmap(unsigned long pfn)
>  {
> -	return addr >= start && addr < end;
> +	/*
> +	 * Kernel text has an alias mapping at a high address, known
> +	 * here as "highmap".
> +	 */
> +	return within_inclusive(pfn, highmap_start_pfn(),
> +			highmap_end_pfn());
>  }
>  
> -static inline int
> -within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
> +#else
> +
> +static bool __cpa_pfn_in_highmap(unsigned long pfn)
>  {
> -	return addr >= start && addr <= end;
> +	/* There is no highmap on 32-bit */
> +	return false;
>  }
>  
> +#endif
> +
>  /*
>   * Flushing functions
>   */
> @@ -1183,6 +1201,10 @@ static int __cpa_process_fault(struct cp
>  		cpa->numpages = 1;
>  		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
>  		return 0;
> +
> +	} else if (__cpa_pfn_in_highmap(cpa->pfn)) {
> +		/* Faults in the highmap are OK, so do not warn: */
> +		return -EFAULT;
>  	} else {
>  		WARN(1, KERN_WARNING "CPA: called for zero pte. "
>  			"vaddr = %lx cpa->vaddr = %lx\n", vaddr,
> @@ -1335,8 +1357,7 @@ static int cpa_process_alias(struct cpa_
>  	 * to touch the high mapped kernel as well:
>  	 */
>  	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
> -	    within_inclusive(cpa->pfn, highmap_start_pfn(),
> -			     highmap_end_pfn())) {
> +	    __cpa_pfn_in_highmap(cpa->pfn)) {
>  		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
>  					       __START_KERNEL_map - phys_base;
>  		alias_cpa = *cpa;
> _
