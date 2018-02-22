Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x227Q4xbeJeUF3hxpWrmIFmUP3QzAJcWa3OQzt4OiU6EJUax130+PwLQQfA/e92xwnalSThL6
ARC-Seal: i=1; a=rsa-sha256; t=1519262969; cv=none;
        d=google.com; s=arc-20160816;
        b=Z/tPxiKAFkovGq+J2j4UqHah2zRolRi4tfs3zH10hTfiJDP4YE9ITXALaT5aoPGJQk
         K1XibV67UgDtg92Z7VwSv0wqw0jDTrhWBHQoXC1rUEt4DJqlH6bZnzljiaZ5tQkr/yxh
         pKhoWaLSvOphU6XEJhsi17lVDe757VklnaY/+z77QA76vgZHYlYhbV8fDLhmSiedFNAH
         +f/2KyqW2lhFPRP8PWKTbwjf4d03vlLiwEXNHQMxQlI3+F0BYBugyUfh9lkqmxlaq1oM
         hJaQxqdPty6LiLSsD+QUPSk18PPhtmiyWp4LAWoNyUioTBXu6sRDazLX1HmO/Y32jdFK
         Z5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=orFUi0a2cexnt/HO3+V4Bw4PJAem06I+4U5Q9HKbXaM=;
        b=TSzjr3JP82XUJC9yR/W4AMiVYz3oYhwbvU0oLg+0DTR3j/8k9nNS3gKMTRncazRlx0
         nK9FDnwJgceAM0uGnkeyEHOwMb5Z2jdYSszvdicEXV+ll3jgkkvkMNyeBqedk5zaH6J6
         xt/aMaCmE+mKoKXuI5t5JUTC9MWojK5J4sjGbthT19BCM6t7PmIL5tWsttFGxFYgNWtK
         oaa89TfAHzdzJq2FFlueJbsocDsCFLAovmnT+GpQn1wwniCA/neuihWwfk1x3DpGK3S8
         grvD1Doq/C+JZqkz4hAPg5zpSRFdm1LmP4gDf3dfN30YJAXuP1dwie9R/fcoOAXwLjuJ
         yRjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,376,1515484800";
   d="scan'208";a="206056238"
Subject: Re: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI
 hwmon client driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>, joel@jms.id.au, andrew@aj.id.au,
 arnd@arndb.de, gregkh@linuxfoundation.org, jdelvare@suse.com,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com>
 <20180221182608.GA11635@roeck-us.net>
 <618f34cd-ee43-d8e4-4fb0-3c23bf03835f@linux.intel.com>
 <20180221214859.GA30263@roeck-us.net>
 <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com>
 <20180222003720.GA25250@lunn.ch>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <b506b4b1-7e7d-abd6-bac2-c45e7c1e0aae@linux.intel.com>
Date: Wed, 21 Feb 2018 17:29:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222003720.GA25250@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027891482896135?=
X-GMAIL-MSGID: =?utf-8?q?1593062687428855636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 4:37 PM, Andrew Lunn wrote:
>> But even with this change, it still needs to use delayed creation
>> because BMC side kernel doesn't know how many DIMMs are populated on
>> a remote server before the remote server completes its memory
>> training and testing in BIOS, but it needs to check the remote
>> server's CPU temperature as immediate as possible to make
>> appropriate thermal control based on the remote CPU's temperature to
>> avoid any critical thermal issue. What would be a better solution in
>> this case?
> 
> You could change this driver so that it supports one DIMM.  Move the
> 'hotplug' part into another driver which creates and destroys
> instances of the hwmon DIMM device as the DIMMS come and go.
> 
> Also, do you need to handle CPU hotplug? You could split the CPU
> temperature part into a separate hwmon driver? And again create and
> destroy devices as CPUs come and go?
> 
> 	Andrew
> 

That seems like a possible option. I'll rewrite the hwmon driver again 
like that.

Thanks for the good idea. :)

Jae
