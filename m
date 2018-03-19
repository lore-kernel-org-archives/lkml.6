Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521452508; cv=none;
        d=google.com; s=arc-20160816;
        b=d0a2yGVSC2jtt5lLHf+lyf1Um26+1WHFNUDAfqjnuBdxFu0lGRuo2Hnb9/Ig4o3IwC
         7MT8UNhrLOYv3fJ+a/w/bZNYk58uj5A0FqJ/1wuxhYJ3MoNNTI1QDh7+U6C6YAfj2cg9
         +Fw7GBX6yiQhP0WwGKvQ3GVcAHY/JEcwKPuDUivgIx77hpjY+RDpQ1ObF2QACd0Ph0IO
         OdgFaixADkRAipkAqC/TF0Gz0FG6BrwDQPKQspAT3gD0QWdgPZkd42TYfGXzGCg5fjV2
         XN6od0h6pdKjzWHIdf3DL3z8Qgpyz/gxcTZzmmm+5DbaFBDQdwkFunL7Wqu8evezn6k3
         4QMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :date:message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=jYrz/f6picjr3xb1PTLePUhgadv4zBvy0oO56i/DxDk=;
        b=KcKcoR9fkHaMRLGG2os3OCxD+mSjjN3hyeQdVbXKU3SN9zEVSO+FO8lVwQeiIPq80T
         IK5ERJsRSmTd1UDzRsD3MtI00IiojjVNQG6wi1+Ddi7h0oxfnoTZXv+C4cUHa8xz4qu1
         sLEXJi0flpJ1scxwoYWlzDsZTf2cQC/8u+ZfAEaEuBerW/pdp4wXl7gCgMCmEbvTNSeL
         MhYnnRKrZ4ARzXWDR0s4gW9obRNKzarLIDYDm3NqPMV2GYfUhpcq/kYPhuvUpzkoaTjM
         sUlQbvlPTXoI0HgnrEd0288KiYU5e3oGOs6IIUXIMAhAn5k0KDM1cfRD5pcHDfVecZj3
         Vl6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=de/LfyFe;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=de/LfyFe;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtyy5GjIgtTp8NvhIT36LcdLIGWY5ClSNuHdgcEHP0sWQyN6XJxfQ7bz8lmvgVWvVQFJTBX/A==
Subject: Re: [PATCH v4 6/7] dt-bindings: Introduce interconnect consumers
 bindings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
 robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com,
 vincent.guittot@linaro.org, skannan@codeaurora.org,
 amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com,
 mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-7-georgi.djakov@linaro.org>
 <20180318224957.GP5626@tuxbook-pro>
From: Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <79b65ce6-1e4e-a8f5-b9ac-1993fca5108a@linaro.org>
Date: Mon, 19 Mar 2018 17:41:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180318224957.GP5626@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495929599493024?=
X-GMAIL-MSGID: =?utf-8?q?1595358585662362386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn,

On 03/19/2018 06:49 AM, Bjorn Andersson wrote:
> On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
> 
>> Add documentation for the interconnect consumer bindings, that will allow
>> to link a device node (consumer) to its interconnect controller hardware.
>>
>> Tha aim is to enable drivers to request a framework API to configure an
>> interconnect path by providing their struct device pointer and a name.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/interconnect.txt         | 23 ++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> index 70612bb201e4..7935abf10c4b 100644
>> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -45,3 +45,26 @@ Examples:
>>  			status = "okay";
>>  		};
>>  
>> += interconnect consumers =
>> +
>> +The interconnect consumers are device nodes which consume the interconnect
>> +path(s) provided by the interconnect provider. There can be multiple
>> +interconnect providers on a SoC and the consumer may consume multiple paths
>> +from different providers depending on usecase and the components it has to
>> +interact with.
>> +
>> +Required-properties:
>> +interconnects: Pairs of phandles and interconnect provider specifier to denote
>> +		the source and the destination port of the interconnect path.
>> +interconnect-names: List of interconnect path name strings sorted in the same
>> +		order as the interconnects property. Consumers drivers will use
>> +		interconnect-names to match interconnect paths with interconnect
>> +		specifiers.
> 
> Analog to other subsystems the -names property should be optional, at
> least when there's only a single entry in interconnects.
> 

Will do it.

Thanks,
Georgi
