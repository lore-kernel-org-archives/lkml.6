Return-Path: <prvs=5812f868a=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AH8x22615OM9YsYfGJ9VBW/rNzLzPEhvlqyUuUnZGcrDn+LjLl/MaW3vj/Qa9NBM+NATnsyhHMGT
ARC-Seal: i=1; a=rsa-sha256; t=1519056335; cv=none;
        d=google.com; s=arc-20160816;
        b=tSMZ5Ekjth5kaIfNwd8Wa1lXZd7CjppaLEtPCL/E+UIV7jC9yBAIZxbiA+6vo3Usz8
         GdLkgF3B2XzwpnDmJJKKBrXbJwwTocFUB6hnIMkVv79zBm1WB3VlmaC0CqjhS6VRFAJ/
         ya7jIF5foVi4Es2r1/wJxYvZFzuUqWYgJeDJcqMkSwmkNvL21ccgHRbxGR7iA6rCYbML
         cAOfH/+xdA29eLmXzgzxIspneW13L2RWum0a4oQRGdSwKoJEe6OSe59sdVofUrwL7CYv
         8LtWPBZegzsJWFToxIHiZFVVT4k/JE2IRht5QCaCj79JCAIznJsPJ6rnyIRAhFtjzY1I
         VdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=OfD9+ly7xWKcJ3tLFxi2mEqd/+W3+Oyb9TjNPbpPTi8=;
        b=fHdCM4XgrU0QS3uGq+AA51k9zudDjxIihuys7ZXkKI0NkPSwOBAK1dPgLLHWhNnFGs
         oxSIA1qxq8L5YrWku7YSQNQBkQY7PvBLP8s6SgpY0VybxY+Gkyd/eiO1JNnV4lNKHvmf
         CrzryHrHVVKBvFuIJVln1+3tTXWO2auLxJPbgbJ6A+1d9s3wxO84GMuAeO+LuqBeEYNw
         XKpu2v5h/9fcn36KvYFGeNHDKBtJClnPyZto6TCM2nnr+GqBdz95KutaA/dsS601cuvF
         3STsUVBgHGVfJhOMMajWPiO+Vz/Ay5q/Jc3ewpfQECqD7sSp0VLr3Mv6rQnVKzMY6BqA
         A/dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=5812f868a=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=5812f868a=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=5812f868a=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=5812f868a=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.46,535,1511823600";
   d="scan'208";a="1283569"
Subject: Re: [PATCH] usb: core: introduce per-port over-current counters
To: Greg KH <gregkh@linuxfoundation.org>, Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stern@rowland.harvard.edu>, <linux@roeck-us.net>,
	<mathias.nyman@linux.intel.com>, <johan@kernel.org>,
	<felipe.balbi@linux.intel.com>, <ekorenevsky@gmail.com>,
	<peter.chen@nxp.com>, <drake@endlessm.com>, <joe@perches.com>
References: <20180219120107.20434-1-dev@g0hl1n.net>
 <20180219155914.GA23577@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <5771d9c2-1efe-35f6-f8e4-58e929e0d72c@skidata.com>
Date: Mon, 19 Feb 2018 17:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219155914.GA23577@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592830659623275207?=
X-GMAIL-MSGID: =?utf-8?q?1592846016903854548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 02/19/2018 04:59 PM, Greg KH wrote:
> On Mon, Feb 19, 2018 at 01:01:07PM +0100, Richard Leitner wrote:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> For some userspace applications information on the number of
>> over-current conditions at specific USB hub ports is relevant. Therefore
>> introduce a oc_counter in the usb port struct which is exported via
>> sysfs.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>> Tested on an i.MX6DL based board.
>> ---
>>  drivers/usb/core/hub.c  |  4 +++-
>>  drivers/usb/core/hub.h  |  1 +
>>  drivers/usb/core/port.c | 10 ++++++++++
>>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> When you add/remove/modify a sysfs attribute, you always have to
> document in Documentation/ABI/

Ok. Thank you. Seems I missed that, Sorry!

>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index c5c1f6cf3228..448fba1e1827 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
>>  
>>  	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
>>  		u16 status = 0, unused;
>> +		port_dev->oc_count++;
>>  
>> -		dev_dbg(&port_dev->dev, "over-current change\n");
>> +		dev_dbg(&port_dev->dev, "over-current change #%u\n",
>> +			port_dev->oc_count);
>>  		usb_clear_port_feature(hdev, port1,
>>  				USB_PORT_FEAT_C_OVER_CURRENT);
>>  		msleep(100);	/* Cool down */
>> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
>> index 2a700ccc868c..b5cf567bf9e2 100644
>> --- a/drivers/usb/core/hub.h
>> +++ b/drivers/usb/core/hub.h
>> @@ -100,6 +100,7 @@ struct usb_port {
>>  	unsigned int is_superspeed:1;
>>  	unsigned int usb3_lpm_u1_permit:1;
>>  	unsigned int usb3_lpm_u2_permit:1;
>> +	unsigned int oc_count;
>>  };
>>  
>>  #define to_usb_port(_dev) \
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 1a01e9ad3804..0bfe410eb8a7 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(connect_type);
>>  
>> +static ssize_t oc_count_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct usb_port *port_dev = to_usb_port(dev);
>> +
>> +	return sprintf(buf, "%u\n", port_dev->oc_count);
>> +}
>> +static DEVICE_ATTR_RO(oc_count);
> 
> I don't see what userspace can do with this number, as there's not much
> it can do with it.

I've answered this question to Felipe already:

On 02/19/2018 03:12 PM, Richard Leitner wrote:
> In our case we have a series of USB hardware (using the cp210x driver) which
> communicates using a proprietary protocol. These devices sometimes trigger an
> over-current situation on some hubs. In case of such an over-current situation
> the USB devices offer an interface for reducing the max used power.
> As these conditions are quite rare and imply performance reductions of the
> device we don't want to use reduce the max power always.
> 
> With this patch I want to give the user-space application the possibility to
> react adequately to such over-current situations.
> 
> I hope this explains my motivation for this patch in a comprehensible way.

I'm of course always open for a better/cleaner/safer way of doing this ;-)

Thank you!

regards;Richard.L
