Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZpJaN2W0Rs/NbQwxuO/AfHnkutFHNKz3pPI1WEq/ZgX4N116cO1s3EGUOBHyw2XjddjSsAi
ARC-Seal: i=1; a=rsa-sha256; t=1525881760; cv=none;
        d=google.com; s=arc-20160816;
        b=SA02DvKZwhRrucg2qy25BCYdwCdGTacvpktRz/u1S/NeYeyqkNEOZO+DasAzqfuNPV
         yh2SkgBUGe07STT2aI51uv6qYs1ZH73GDnGjZQ7x+VcoyAkTz0VXCir2xkMzttyfqz4L
         GjwjD/yld2FR0hQnD3BEnVgtxamlj3BNTvDpsXFAHyKMpy1+xYt9E6hMvXGIKJclZyz5
         2jwhMuXaVfucxcgxTX2ij11enRSyKqphUZKF1zzaiO0OlD8baL9cI+hkdOvEoEVt6cfL
         thhuvYHHgUpjkYoBcIw+tpBQq5P0MSiNan1sUKNJHJvJmO8fL7aoYz1ydqp4/0e1+xyP
         S3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=w/udt5sCmHLlXnhL/zsTcgwbaJ1++fOzB7piWh4Ehu4=;
        b=pF669cTOrzliERQO2sN+YzEVLur8DzjTBdOr/lAFUzlffXGeC/4mWI201UPYqg+TDC
         yb5JTitTaRrsONfmpZE0Dk0GUJ0/oc2FYxmWWjoivBNjB6tydB3nSx59x70b1LmcNti8
         XdgPTkDkiI5/C9/sla9pfClcoQfQ1AssI1KYJSrmFZiR/k0clYBTEeVyzyayOG/xBgVZ
         PFimVTP6+9VrHZVPKkpW1jOYrkwvY+oiHOmSNULVjDM8sL8gIbc4zAG7+51GS5INEEwB
         +Ip+zE9ojdhZgoHhYItS0vT6SYgu33Q9YIzyWIQnRX+EBzpMERrimwy+px0G1SY8GZ1v
         KaKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai
 <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <8c2648ec-1379-fb2a-35d2-b3fa8fc9f063@arm.com> <20180509154055.GB25559@xps15>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <19c4b830-9f50-d5ea-3e31-587477210ee1@arm.com>
Date: Wed, 9 May 2018 17:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509154055.GB25559@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600002993077958454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/05/18 16:40, Mathieu Poirier wrote:
> On Wed, May 09, 2018 at 02:38:32PM +0100, Robin Murphy wrote:
>> Hi Kim,
>>
>> On 08/05/18 20:06, Kim Phillips wrote:
>>> This patch is provided in the context of allowing the Coresight driver
>>> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>>> to bus_find_device() in of_coresight_get_endpoint_device() when
>>> searching for a configurable endpoint device.  This patch allows
>>> Coresight to reference amba_bustype when built as a module.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Todd Kjos <tkjos@google.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Thierry Reding <treding@nvidia.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>>> ---
>>> There was a prior patch submitted by Alex W. here:
>>>
>>> https://lkml.org/lkml/2017/6/19/811
>>>
>>> But I can't tell its fate - presume simply delayed?
>>>
>>> Coresight uses amba_bus in its call to bus_find_device() here:
>>>
>>> https://lxr.missinglinkelectronics.com/linux/drivers/hwtracing/coresight/of_coresight.c#L51
>>>
>>> Grepping for bus_type and EXPORT shows other busses exporting their
>>> type, so I don't think this is the wrong approach.  If, OTOH, Coresight
>>> needs to do something differently, please comment.
>>
>> Exposing raw bus_types is pretty ugly, but it is indeed the status quo, so
>> this probably is the reasonable thing to do. I suppose an amba_bus
>> equivalent of of_find_device_by_node() could be implemented, but for only a
>> single potential user that doesn't seem particularly worthwhile, since
>> unless some massive shake-up of how buses work comes along the bus_type will
>> inevitably end up being exported for other reasons anyway. So, in the
>> context of this series;
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> However, as a wild idea for sidestepping the issue completely (or at least
>> keeping it within the CoreSight framework), at first glance it appears
>> something like the below might be feasible, although I may well be missing
>> some obvious reason why not.
>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c
>> b/drivers/hwtracing/coresight/of_coresight.c
>> index 7c375443ede6..2c3fdc9b63e6 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c
>> @@ -27,28 +27,13 @@
>>
>>   static int of_dev_node_match(struct device *dev, void *data)
>>   {
>> -	return dev->of_node == data;
>> +	return dev->parent->of_node == data;
>>   }
>>
>>   static struct device *
>>   of_coresight_get_endpoint_device(struct device_node *endpoint)
>>   {
>> -	struct device *dev = NULL;
>> -
>> -	/*
>> -	 * If we have a non-configurable replicator, it will be found on the
>> -	 * platform bus.
>> -	 */
>> -	dev = bus_find_device(&platform_bus_type, NULL,
>> -			      endpoint, of_dev_node_match);
>> -	if (dev)
>> -		return dev;
>> -
>> -	/*
>> -	 * We have a configurable component - circle through the AMBA bus
>> -	 * looking for the device that matches the endpoint node.
>> -	 */
>> -	return bus_find_device(&amba_bustype, NULL,
>> +	return bus_find_device(&coresight_bustype, NULL,
>>   			       endpoint, of_dev_node_match);
>>   }
> 
> Hi Robin and thanks for the input.
> 
> Your approach would work if all CS devices would be on the CS bus, which is not
> the case at discovery time when of_coresight_get_endpoint_device() is called.

Ah, now I see that obvious thing I was indeed missing - I got mixed up 
and started thinking bus_add_device() only got called as part of driver 
probe, but of course it's actually much earlier in 
{platform,amba}_device_add(). That means my idea cannot in fact work at 
all, since both ends of any link would defer waiting for the other to 
probe (and thus call coresight_register()) first. Oh well, I guess 
poking amba_bustype really does remain the only reasonable answer.

Thanks,
Robin.
