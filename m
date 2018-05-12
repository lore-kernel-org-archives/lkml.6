Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeELBVf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:21:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:31672 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeELBVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:21:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="40616493"
From: "Dey, Megha" <megha.dey@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Topic: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Index: AQHTiaT71VA7Q5Or9ESQdIw+yX/ir6N6FLYAgFlFdnuAMogJgIABiP2AgABwaXCAAKKQgIAI0PhwgAKZVoCACDnDsIAJDTaAgAVJM2CAAK8wAIAA46lg
Date: Sat, 12 May 2018 01:21:32 +0000
Message-ID: <C440BA31B54DCD4AAC682D2365C8FEE738C61026@ORSMSX111.amr.corp.intel.com>
References: <20180316145351.GA6231@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13267@ORSMSX111.amr.corp.intel.com>
 <20180418110115.v2w3o5yfv4u3gc4r@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13DDE@ORSMSX111.amr.corp.intel.com>
 <20180419032525.6csodbz6lrksyudd@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C270FC@ORSMSX111.amr.corp.intel.com>
 <20180426094445.4jiwondmtbenepo2@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C4291E@ORSMSX111.amr.corp.intel.com>
 <20180507093511.jscgnk436e3ba4un@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C60300@ORSMSX111.amr.corp.intel.com>
 <20180511044530.n6ht3mpvg22hqny5@gondor.apana.org.au>
In-Reply-To: <20180511044530.n6ht3mpvg22hqny5@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWZjZTE5MjYtNTY3Mi00MWJlLWFlNDctOTU1Zjg0MmQzMWE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IlZLMisyZ2VEY0dtV2dhR01zUVBmUTBJdDlqQ0hBMXdka1k0V0U0emJnZlU9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
>Sent: Thursday, May 10, 2018 9:46 PM
>To: Dey, Megha <megha.dey@intel.com>
>Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org;
>davem@davemloft.net
>Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
>support
>
>On Fri, May 11, 2018 at 01:24:42AM +0000, Dey, Megha wrote:
>>
>> Are you suggesting that the SIMD wrapper, will do what is currently being
>done by the ' mcryptd_queue_worker ' function (assuming FPU is not disabled)
>i.e dispatching the job to the inner algorithm?
>>
>> I have got rid of the mcryptd layer( have an inner layer, outer SIMD layer,
>handled the pointers and completions accordingly), but still facing some issues
>after removing the per cpu mcryptd_cpu_queue.
>
>Why don't you post what you've got and we can work it out together?

Hi Herbert,

Sure, I will post an RFC patch. (crypto: Remove mcryptd). 

>
>Thanks,
>--
>Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
>http://gondor.apana.org.au/~herbert/
>PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
