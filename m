Return-Path: <aaro.koskinen@nokia.com>
X-Google-Smtp-Source: AIpwx48rhZRA80ugIUiBFlH9PLWYX5pi6BkCDpfNQy95A5DJ+gcwo+7qrEEPyBdHhgK9wxCsvmf0
ARC-Seal: i=1; a=rsa-sha256; t=1524480726; cv=none;
        d=google.com; s=arc-20160816;
        b=HU6y9847q6fplystBCEoNNVHLiNT50yDbuMr3Yteo1S7Q2nHMy+Js0QJrJsfwpTx4o
         KouPYWBXwc9/iMZIDAStlUxDDAMYrHReYcj7yPHPnAZCQ0CFkGSTw3iFo9ojJHjcTXd9
         5h5LgAHFo9mMh1MMOd3Fg5LBcamoS4f2c40oZK6rRkbbkd/oRKEs7h7KRR4bEJ6SL03t
         IZVF8smNcFyPYj4wyzk22noib0FuHr1sSq3EhbVEKj/caiNU11FrJAmCQA8Y9GbULHqi
         t63mHO480AUs/Z3xCWDzdOi95SaT7Vs6bE2qOJNHdptyfDsGDDUXRIZsqNFZ60F1lP6R
         491w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=13jiLGc8vqNaCTDC0AwpPOUBf8RodTDRrTS7JMye/T8=;
        b=YDrl8IM2Q1VJfrG+fbrK/Yr5qrCi1p1omuejV0IoAibqmweisuFFzIer+KeDjatpfm
         aqfTUp1C0WkElja86Hl6VoLFPCiSqf8OFhAnTAHn+Vj431SDGjqkJQL115smqj0OCwjp
         Y4B3lDuel85GYvZ0pA7FQ+2nkLGU5hBShuU7EQYwiCw118EwtIexjxaYkSFFvOBLBJAo
         pqb0HUJSELtnKC8HHGqmboV+YXUj5/QdNRH33TTFZivHkxBQZizIq3d2JVoZG/Y3cMf5
         9V/y4Ejxg4EzWArnOAYrWl7t1SWCL8VT6GH8jJ9+U15L6xeIZRojl9s5NdCa3VzsRWxj
         jZtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=evkaQO1M;
       spf=pass (google.com: domain of aaro.koskinen@nokia.com designates 104.47.1.106 as permitted sender) smtp.mailfrom=aaro.koskinen@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=evkaQO1M;
       spf=pass (google.com: domain of aaro.koskinen@nokia.com designates 104.47.1.106 as permitted sender) smtp.mailfrom=aaro.koskinen@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.145.164.233
Date: Mon, 23 Apr 2018 13:50:50 +0300
From: Aaro Koskinen <aaro.koskinen@nokia.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mceier@gmail.com>,
	<aarcange@redhat.com>, <luto@kernel.org>, <arjan@linux.intel.com>,
	<bp@alien8.de>, <dan.j.williams@intel.com>, <dwmw2@infradead.org>,
	<gregkh@linuxfoundation.org>, <hughd@google.com>, <jpoimboe@redhat.com>,
	<jgross@suse.com>, <keescook@google.com>, <torvalds@linux-foundation.org>,
	<namit@vmware.com>, <peterz@infradead.org>, <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] x86, pti: fix boot problems from Global-bit setting
Message-ID: <20180423105050.GA16237@ak-laptop.emea.nsn-net.net>
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
 <20180420222019.20C4A410@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180420222019.20C4A410@viggo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(3190300001)(189003)(199004)(377424004)(9170700003)(97756001)(2906002)(76176011)(47776003)(5660300001)(9686003)(44832011)(7696005)(4326008)(59450400001)(126002)(476003)(446003)(23726003)(33656002)(229853002)(486006)(54906003)(8676002)(8936002)(81166006)(55016002)(50466002)(11346002)(6246003)(106002)(53936002)(1076002)(22756006)(58126008)(16586007)(7416002)(356003)(478600001)(106466001)(316002)(46406003)(6916009)(39060400002)(336012)(26005)(77096007)(186003)(86362001)(305945005)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4393;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT022;1:J2DQI1p3dfzaJcu1P1j6sYyq3iCQz16+3xbOCqQWs1U1dp1UmxdixkM5u46jDf9GuImFrKkFc62HqWOjdU3KXdeJsvcj+pmbXyyMdjwMcqQOd/9UJfHkM6Q3zbP4kiXH
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:HE1PR07MB4393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4393;3:TY/fAcm6x1Fzcn+xOKKTTnb7ZdzFKbYCo51oKmrsRotH3FdMJE/BPAXeWNwknUEhOT4E9mGbxUd54FxhkZbqmBDxW/zdRHV+85PwwHt53sKSO/cXaKYE+bGMcooNKFz0YNpE1LdD6XR/pzFOfVBblHMsGt6+1/b6ymeaKK9tJ8x1udhkhpE7a098ufWC69BhP38mDW64AIluvqOtyT1cGgebXMYxbzTahsx7g8H7Gt6MbQpj8b3eA3O3mx2+Up5LCPB/mlw0tU6iJWE7FbnXBSrNsA13RSEgbL1pInqLgM4cr8OFiNwdUMT4F5SeJBa7l0UpYRFyqai3YvFV6vw5SLwX/7LxaRoU+m2VVQyP1Co=;25:YyHlVhICjQdOhi14nedPpdp/I2qV//4842wU0/8p4oKwTWY8sxI2Cgc7pakp5MbkX4q3XF2RvI4UOABWcs80Dj6Yt8CpZBiu6pSYwDZQQqXUucl5B3+wtw1P77gs3Gr1OEUmbI+aVroLTAAi+rzc2ZWSWA1ppZfYC3ZeLdCDlqguiGC6xi5FkUlSiffjkKZzt/9Ugq3DfomaUtL0fRT9HWGMs3B24qbkIzFCEmQJw9xUCp1d5n/TXl/ZdNpooUCFP1xbbsLiM+WqiZK+2FpJWY2whB2ibjc4VWq9H3ckVvkafyh9BPPUXRIXYQv/eqMYVA3FQi4fjQ21eIXtXgqPkQ==
X-MS-TrafficTypeDiagnostic: HE1PR07MB4393:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4393;31:ZLFcU3zb7JozimFyM5Y5uyZDz9O8GBL48f6IXu6Onoyvsf6YUqMVAQeFdt2Nf4eXCrDBfFmjDMZsDwrJUANYRc/ZR5WAWmtMgG3zaU9GjDhn781lDvT0otmMrD2J92GuzVOr2xljeC140U9D9+6GOf6flW4cBLZX8dXD3kX6c9iIEl4UleF3b0N+gmfIJby2VWBG6EisCe3PwIsMoq+h7xD+oBsHB2RgQVF+ehOaQNo=;20:LTYdZOpyT/gWdSZL1Uy1dr6263GfZi4OKFUT4nB6DusJtBTNzkBGBfHFuzJoYyg/z/rakuk7EXEjRrVeEbVTFujyoJmrGOlNXiBEyWbT0AcegyRQjqNNybcdQ4akgNf4Jnhbl/tQcQB4rUhlzcmS7/rs2RDAShZkNjablOv4CyH1wXLmtS5RHlLVlA9Vkdjded69fwvxwvKpM24IVfV4asMlEWTwbt7hF49n/izzal1R7WP5fNSf7LNLvodkYzRbqXWSmDTN0LEjNK61zJA2OSdqyILjtZObSpz+67n33jC/Hk55LOZHC86ojfhBJYSbOc794xJOY0+E36Z5mBJHem23/JK8pHKV4vlPsqLJbAf/QsfHG2zGoGmq4S7RvEbHKuSNWMDzTGAZ1+AGwToWtrC5E9CXyF4BX21Rckr/9BKgoPoSMy66069qPoJJPrUgFKKTsV0xQguAifv/08T2U8CaK2tXD6oj7F4ttIfqok1bXAPgA/ZCzOnf+9iJUs+yNVFJIVm1cEo/orDNEpzx02YUxBxnUiYJ/AFsiW5sYSJDtsCepkv0pfjp8bhRID+hLsMWALuBqkHlZ3j8ilFwoqSDYNTIcwrcuyNaU40T9OU=
X-Microsoft-Antispam-PRVS: <HE1PR07MB439358CAFD0A6B559194DE5FF4890@HE1PR07MB4393.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(82608151540597)(85827821059158)(211936372134217)(153496737603132)(228905959029699)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231232)(11241501184)(806099)(944501410)(52105095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR07MB4393;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4393;4:plQ0VJbbfAbP1NNarKIK6gJwLBJZW8KzFpcC35NoNUTd7ErglN1BLNqvDFHnbmsJPyS+FGlc6lg/LVAjUuVmGLoequT3iFr7lx8LQnUx/nLcXhgKkaN8icVrzNV3TViH8j8AJL9kwMO2gPLfkeDcOIeXNC/beafW25lHOjc5ZiGEf1eEhiAqnTKagsIX9Cx1c3xMUflMPEfemjALPkN1oqZGePPJO/39J1oSAAcqvqwltH8sZosrKJwSW6rekToqLn3UhNdhZ4FU0zA4M9YHmquu48BbnHlWPQHTAZCIZegRO8yg00Rj0QRjDxKvAf/8MpfRI70fryElrW84+YkNf+7sXXbw2LwXffgtE4DJIeFozMiSJGv1x3MN+VCuugmPS//ff345ERgdbP0R6pVbmlSqkcGmV3RgkK/auMqv2Z4+53+aIxlzI77+7NZRkeytosqY7Mrui9L7hj64xgqxUXC+zZSwLGju7aTrCQ+rgsrJXbQadRSRwfXRs70inBKVl1HTSf42Wnro9GVWKgwfUg==
X-Forefront-PRVS: 06515DA04B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR07MB4393;23:4+1jcHlNezVA5c6h6j5YdtJw+X3zI0EAmXaBugCnR?=
 =?us-ascii?Q?4LnSx6r46m/OmPqaTxPvPlrKpLOg8kZu7YAvQp8iqhX1OYjcuqqGvZcdUYHU?=
 =?us-ascii?Q?lgWFIFYJeeEuhAL3BPgvxNYbL9RKedim5vV0rNgxIbrXVajNnsSM+s/CWRRm?=
 =?us-ascii?Q?uQ0Jf49+oF7QWB+1QwmuxO7+SUk+U4JzgJkKlbznjPEk9NgkrHgMeA6n17ba?=
 =?us-ascii?Q?heTA/m+iIj3U+fgo4mcTl/bDaKFZu/Y4Q7bgJG+8b7urTLvPlO5bssutZzHS?=
 =?us-ascii?Q?Ei2mnPsaJipDKHTLsxCFo20vDd6ymEsiVN/VBu0HURlzzMU/ediDXhrdnMeq?=
 =?us-ascii?Q?0uKtXqpaczzYV523JMxAFIaXCujB5d4NIGa/bksGXos8uaO0NRgF9Zpc+CNi?=
 =?us-ascii?Q?i90tQ58339d7BJ8PtgrvU4AiZ/D8Z4qcNM6fpknSuApiV4BQrCDXb6yewawU?=
 =?us-ascii?Q?tYe/hfh4TfdCmxma6SE+tpXtQ0dL2P/08Px9Vubyiy2V6PVg+Zsm+sH0OWZv?=
 =?us-ascii?Q?ZemCy9smcW7zY6Pxs6AgUDXnI/1wmCP44MhrSqQOzQFZ9RC6Pl0/zNk7B3Hc?=
 =?us-ascii?Q?tbJmkt5//2nHMR/SKrsGGpSOeV/v9B/IbNygVvfsRNWHNFUOJ/nsUla3Ciml?=
 =?us-ascii?Q?bn6wbTVggphw1+kf/zSCGF+cwumsD9EKhdbv/w8tIX6OljexTrXrYybmaXZk?=
 =?us-ascii?Q?LTRS3gafnJ7YBDIOofYhLD1w8mc3mUywjYfVDc0+usW3OJxB56vQMCAVVbXP?=
 =?us-ascii?Q?daF6pGIw3N/jBy7SrqF5O38j577CDhiSVR34kEMy/8dmOeMm8qxOU+MvGaat?=
 =?us-ascii?Q?evFRnHGGwiL+fTAaPJ6gxaCixCdXABalXGz0ComArzvHRCs7dgqpzimRRcT3?=
 =?us-ascii?Q?/5rrAUso0OTfqGDRHtZupTr4v0b7x7q5TKWisIKPA2VCFdVAsAczhunEix1h?=
 =?us-ascii?Q?sLWNijy0nJibcUo1lX0LHFqj3dylrPRgiFvxXjNB0lTYy4+GqtEcgV79y/IK?=
 =?us-ascii?Q?CgQeGHE1+96RK0Gtr2cA69FbEMopixES+xiN0YODY90rm6S1aLHjuy03OVnY?=
 =?us-ascii?Q?2grzcyKoaS0SEP/AJE3/7wXzCRjixt3YOuzZoVWUn7Z+Vdxrfkx7d6p+mXOD?=
 =?us-ascii?Q?rt136wLUCq7Eyu51MUbwnE2UUsFIf4hBBLBycbCTANzK+Xe/Fhnx7C7zNLu8?=
 =?us-ascii?Q?b3eamgCtE2BWfcJm//GfnJiIvzy8+vfGl0Ea2z8OeQjU1+/0aCpMPSz68S0k?=
 =?us-ascii?Q?PHklrVo5J0fHD/isV9RsB2eyVFPMJq1XNDv9t3lBCWULOOsZeKjHJysfNVm4?=
 =?us-ascii?Q?pfqYFkPJHAj4mp/qqLIHxA=3D?=
X-Microsoft-Antispam-Message-Info: aTmybns+WCGJf00aMvAEsoQIT/hRNTyktdCe0g+fwRTo4+CTAHdMES2bXgEsUy+uDENXPm5pccdZMwYXhzyD7Fke7vbfjqUg8BTo+d7B+I+WQG5TvZKfreXPAsGElVlw5YW2mTvgwjlD/j+xhADaLyJK+HL+ep5JOw8/s19FRU+9XmxyZB7MR49/1hJFVjARfRiFs/xw2NXOHOLPoY7+WVmOGIfQX4yqyKx9sXhCVw/Qp5g9C/SiU2fLuIAAqlpNEbZdSqcdhgDNF2hR83x2r3u6Z9CtWRqh0wp/JVYQ4NDJ8aW7dZeaeaAq8vWde79woV5p8OVPSfnPJ2+cIw7lmbfKAFZz78Yh5jG81zGIcWJMwekA9e7dXGISYfc+dkrf5gKUeujSlt8V9omiZxVSPSNtEiP4vAuXhTbp/q4d3ASSReq77S8jxXB9WXd/eB/v9FRZzsgnR2ku8IZ7uVnMdA==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4393;6:tPaX1TTa2Y1RvaxFzeGnBSBid+6JkTweQErA/PnwBER3TDEEuCRqiE9uM91aXgL7C/g4/ALCjQ34It1VklSzvDbYtfYpDZqrLZh4Elz6kKdnv0XMJJ0kKJ3JjhyKMYKvzSFyI4XPGovNOUfk3Gp8OVX5mfbK10Lyfne7dApVrsHGvczSsFcfEJgXhKP5nsOtpB+tQ2w+MIVPfEzMd+fcLzxlGFokk+enHn/qlsJ4wad2jGzlyXT/3hb85KXvja2Oa2A8K4G0SEthIeudY2Nhn6ltfVUxSnlG15FlS8AwtI9UXIN1ze+BX/fpFgu7dNkCu2Rmw3rdoDZWg9/HTGj97lf2ZSdY0RyRRAOHRa0zvDTi7nNPzNKdlTabexIAVKidCXs+9nt33RFsFoJMHqdv6OsInEEL3ylEoJI8RwIWFN2xWWR9XtPpgnxypQaE47SzKCu57nx7gjqAjUjyzfipxAS7PVB29Nn6JBx5/EnzZtWqfL7M2yNhcXlFdPBRtoBe;5:klC2ZwX+Gi8T14XBPJo0hUhm/+5siio9BKPwQA/7wMNC9fW18LrjetlXAisTi3g8+q2pez6TfiFxrMc//lDNG4N3XFP27bq/1KXXm67lcmdd0yVdApYj0tZE9bzOO4iZyy5YInfaIdnWLcyDB/u/OWlUYyy1PMYXDl0NGyvsqCQ=;24:NpjwLJmtl2Y4QvOq53FdEuB+psJA/oJAKZQG3bU89sho9hRVxdVt3EgRiHVtswx47siPhGicqoJiHKivELfWINirf/tHM7NEoMAoa/Fzxh4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4393;7:fmsSUF+Pv/83EeA6ZVfEHOyFrlKon2dlxNMAUl/UUmF6mgvJQnnwXDcKf6r/aUh+hUyUAH/M/wuR5lFgWVBuOIiRwNiEOY6XUs1nGiZ6AqnLcwO2gHd/IUFDMZsr+f9cagPRlXQU0bhkYISdlxp2UFG/1nJ/m/Y08q1dKeL+L2irlcVTFCf4gw0JVsz0kHof9kICe6tFERx/L3mM9GQ0TJsY6bGaSVluKoII5zj1l62iapP+4LVzq9/EFchEuvSn
X-MS-Office365-Filtering-Correlation-Id: 033085ed-8090-4009-3320-08d5a9083e95
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 10:52:01.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033085ed-8090-4009-3320-08d5a9083e95
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4393
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305654028969695?=
X-GMAIL-MSGID: =?utf-8?q?1598533902723302605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Apr 20, 2018 at 03:20:19PM -0700, Dave Hansen wrote:
> Part of the global bit _setting_ patches also includes clearing the
> Global bit when we do not want it.  That is done with
> set_memory_nonglobal(), which uses change_page_attr_clear() in
> pageattr.c under the covers.
> 
> The TLB flushing code inside pageattr.c has has checks like
> BUG_ON(irqs_disabled()), looking for interrupt disabling that might
> cause deadlocks.  But, these also trip in early boot on certain
> preempt configurations.  Just copy the existing BUG_ON() sequence from
> cpa_flush_range() to the other two sites and check for early boot.
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
>  b/arch/x86/mm/pageattr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/mm/pageattr.c~pti-glb-boot-problem-fix arch/x86/mm/pageattr.c
> --- a/arch/x86/mm/pageattr.c~pti-glb-boot-problem-fix	2018-04-20 14:10:01.086749169 -0700
> +++ b/arch/x86/mm/pageattr.c	2018-04-20 14:10:01.090749169 -0700
> @@ -172,7 +172,7 @@ static void __cpa_flush_all(void *arg)
>  
>  static void cpa_flush_all(unsigned long cache)
>  {
> -	BUG_ON(irqs_disabled());
> +	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
>  
>  	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
>  }
> @@ -236,7 +236,7 @@ static void cpa_flush_array(unsigned lon
>  	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
>  #endif
>  
> -	BUG_ON(irqs_disabled());
> +	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
>  
>  	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
>  
> _
