Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759451AbeD0V6T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:58:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36649 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759262AbeD0V6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:58:16 -0400
Subject: Re: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check
 alias IDs
To: Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
 <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
 <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
 <ba081812-f532-5ebd-b052-cdeb1f02bff1@xilinx.com>
 <CAL_Jsq+3WnGNM0ip_v75s8f5-Wq_9ht19-T-MHyhKjzcU6jtdg@mail.gmail.com>
 <147e8ae7-3682-2350-394a-828c096f5ee3@xilinx.com>
From: Alexander Graf <agraf@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=agraf@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBFJpUhABEADFUzxmkJeomCBLqm9Jtd6Iqp4B44JbEYoH3d+LegNJGV/CSnBTlH+es3yD
 v+y2Ke+AJsYqpAdry4dP8QpCe91+U/0IsI5V2WIyaKP39Zc/BYYGkhGXOgnE/4bIUL0Lomzx
 lxRaJ3uXZtU0QWgsFAtu6/Pq4cCJqdzB488MzwmvojMkNPwocwvAqhQkBxJQIbqV3wK9+oH8
 O8NdWJmt/InNgEwWfgugIHATFSETmTlkIjUT0c1nhLLskVcYQiYFlk+SG/+P7aIQuR7jIaUv
 yA9VUfYAyh9WGwGwDL5zpZc2pz47bL3JhqdhDiEuglkDsGxCyk8YH6AntPlcWqKJ3rGlVfyT
 8pvplU2aBhwKfWVk549MEe5ePLIuSNNuBqVDqIH3BiuRfYw0Sn6YL/klZCMvQIKDj3P5nviS
 ggtSLbv1bucxBiY9mKv0x/hHb7hwo9X4rO3kJaYox24oarZpOBshrqwjaA1z5cJeHsdzIhGx
 L8nxsbRFSk3Ci+sR0WtPf1/yJYtTmgQ1O5xllvBtVyNiifQ2bwgfONeY/4wqF5r9+hNOG/lR
 dbv1Z+/AmcAo/jt9Rt788H9iB6M5SE1pEp6UecY5OvG7XpUgGsjfJn6z22bINgD2HsLHAcuI
 4ss79ZaPzP/0kASGk10roH9Y2MWSoLX4VdskN5keJYUtKe6xDwARAQABzR5BbGV4YW5kZXIg
 R3JhZiA8YWdyYWZAc3VzZS5kZT7CwXgEEwECACIFAlJpUj0CGy8GCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEBYxMNpbJFMKHTIQAKDFXsBrDuiXqVVN0XPls0wDS/0hC4TEFIuuFWjo
 p5YL9mQzw8pRaxs9SD4YqelrVeTiOht66YjtSEuTVA/g/68ogPyFIIKrSXbIaoWKI8XT+I4W
 Fz5eKloxzpKns+5rM6QUSsK3LIVzWYShNO7/lp0GyAgiRTgj1OwC1mX8q9B4xB0aUYDlYmLf
 qDuoHicPNChgz60JCeZsG158zH0OUKIq0lOxg1v503izQKUzA+zFCFqA3AgRAgHnTyJHa3GZ
 6o/uWjTTX0zqdkx8wCIC1g99nB+BzCr3McfchkS2ppVzh6hx4T0ng4JIOsOzIyQEAAwwH3Ph
 GHyvvF7LRC79Y/XBCXS1/CAgHRlTjeuih34Sf0kO0RmNpoqux2RYkn0R6b71gKDFxdY3512R
 lhfy8JcWWLFRJFP3AMhiSFxAxObLfRJM39D512cPUMqKluDh15YmqB076I//yw30SbpgLxV+
 aS9iJkIEYaAbnPYvTLBKT/CL1Crj2nOCe60zQ9k0oz3dCFAwoklqSRbSxS8AAQBthaZY4tfj
 z2/pEjiVe/tvGnnaW5MN+meb/KOYXRFNCxRVvZ6Fy7ZuqmX+NC6ILN6DadFUYSMxZ/nznJcZ
 Js9Yd/KArW/qYtzkgxhYFF2xCIMyZkAepoR7nxeY9IT6oGiiuRk7PozFjcwRC0Rdy+AgzsFN
 BFJpUhABEADOTHgipY9H4CDOhcA9JnArlNcnDsXBaOOvv5ts0sdcRxBb8PNH35o7oEozNYTW
 GR8O1dzKDtn4zjIxY0tcRzrBB0dlQRRV7NYOLEGXTa6Bf55YR8Bv8ahh8mlNN2EiBn6WRREw
 krTuJet/o4vOwt22Hqts1KjMY9pOnV0kggl0NrNP/Tvhc6CNauo5ezz1PCrmO5Wgk1WB/E3G
 AnI4wtHyNHyRI/6deAM5u79GVO5teYTtf2ykpCR74C9oF5tqmLYsLdKz55IYwH/LRXkQQIqq
 nMOFvuhlYx3NZzu8vUZ16nxspDJYEgbVzny0J5/Ux9UkAi/K15CsNBAQbGnPgwo1WZzTTXQn
 7FM+RyP3flqYBlNZ6NbroP/DRS9wKVC5ewe79wXEoQep7o95565ORDwSWMykQV99TvBTP45q
 vG11V2e02F36cORrIL3UZOM+HXYc4QAA/FHjnC/nng2lezYu/mZ1Aj/ePJmEOaygNYOij1WH
 A5xBelr9zR16BPExz/li6ghqTUbOtBJw7/5KwYNc7p1vQLHGW7FQaO0u8V4CUIjpJdc7ge1P
 yI5cTfCL5VfuQ12N8iUJbsmD6Z/ZLcYChPvlq001VI5hUCLzwxS8/qpHngLtWnMRNlJoHOO5
 L8uOtMejd5aKY5hvYtEFrsQ4MHyQdqkva9aTDfxxqV5p1QARAQABwsN+BBgBAgAJBQJSaVIQ
 AhsuAikJEBYxMNpbJFMKwV0gBBkBAgAGBQJSaVIQAAoJECszeR4D/txgbOYP/0MxhLrpZOEl
 lMmAUu43DPVk3pWC6BxUaigtC3X8Bnmg2JsZ2MlWIks+l/TkTh2PrrkspGLzm1aw3kG2+sb5
 w+dbtY8KLdaMbJKwd438VRQN729gi0zCOlAjdycmVEVYdgiMdUL4Qb9RR1uaPFha3/iW9WlR
 rVQWCi+gfsx49Mw8PPixraGt6yPBWhb66GUwqPfOshLJIYenPG3CkRlwCa/a2ECCjU2PeOGx
 W2BjWPgDx5aiJHhvNRo+7Le17uuGAobFcdkskK5VDqCvxbnKKjKGdgW9EOPRw6DJiOBt7Vrg
 H4H3RfKNG4y7WYbBuq3dW7qHdflku44SoG6ZTsRVfBZRFDioQf8QCilUhxwUbJjrQd/TgZiv
 kB+14u+YQy3sFnzQVU9FQWB1NzOOcd66nQrBcoEgG6s2GbbqC9XMDtPEhfG7ydezeh0BLYKl
 nLe/T25O1W///PVNvBRpQEU98eTT2Bv7/+zIGfcFkU6qXjc5Tx2hjEVvA8iJyosaI9/PGjCe
 lxLZBTuseMepFfKsyeLboCetFzx4fRikvVTtMyspc4JgVHlnwqXDE8PUZ4TPhJezsMDKiugu
 EcCdO0h7dfIeDVSDAx9rHvIpBI20i0RCrsBP+cbULQIPIzaJ95m5plJTIZPALa5NMeH3PuZl
 o+Dvzankq+Hj8ozqMPSbI5P7ZnwP/RanKlRztdcOt/GQdpACovKmMVChbZrp6z94yhYT25iG
 EusiAUwar9ViWnZVYxt8DaEojMkpSPXfFh2rFhTjrjWTlqmTTa5raYP3lBHzv4DlYoJtApo0
 GiSyqd7QlXYQm3abFfI+6fnszg8dYz69GYVkwBpHLz0nA/u7XdMGYgeRiwHfWLVCxjxqoguw
 0YSOnGFXfemuvAaVKfB0qY18F5j7SoUy72e5HnLpNg/zj3CBZFM40df8K+zqwtWfQicOM5IJ
 g1m5nhiB1rMWywSZ2pYkPHVjPJ68MkvCChsK5vSl4sIEoYkZnkQw5J+K8bwqaZZL0REK9xhH
 z+1FvVl7zEjCZXvyUm25ZS8iqAnlpk9UBFjXYKX8Ut9Y2iIDz3Pg3/FCLXbJSCQ6mIEe80Ns
 U2+L0x4LbU/JSxdN7+JC+1K36P66yBsWXk5347UdzPkvq6nlUqHPLpqpl4p+KzxI1TKK8co3
 0gebQn/WLY3gqt6vCht2mdJztWPCL+r5kYodiYnpDXY/7SFr0+46QLRF1xG0J5UYGnz4koot
 3173uxYy75CNZqYpqpLivEG6NXmGUNFypsbGuEhsAV2GWGyf0uT91XFE0SlRUxOMEHbLwwhP
 iMLccbHM2Kdf238nBUehU8iIsw/q6BWWw60MXH4Rw/1yya6JYvIyaG8ytoKhv8zZ
Message-ID: <e2039dc5-92ec-d3a1-bc4f-6565a8c901ac@suse.de>
Date: Fri, 27 Apr 2018 23:58:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <147e8ae7-3682-2350-394a-828c096f5ee3@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.04.18 16:14, Michal Simek wrote:
> On 27.4.2018 15:02, Rob Herring wrote:
>> On Fri, Apr 27, 2018 at 1:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> On 27.4.2018 04:39, Rob Herring wrote:
>>>> On Thu, Apr 26, 2018 at 9:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>>> The function travers the lookup table to check if the request alias
>>>>> id is compatible with the device driver match structure.
>>>>> This function will be used by serial drivers to check if requested alias
>>>>> is allocated or free to use.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> ---
>>>>>
>>>>>  drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  include/linux/of.h |  2 ++
>>>>>  2 files changed, 51 insertions(+)
>>>>>
>>>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>>>> index 848f549164cd..382de01acc72 100644
>>>>> --- a/drivers/of/base.c
>>>>> +++ b/drivers/of/base.c
>>>>> @@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>>>>
>>>>> +/**
>>>>> + * of_alias_check_id - Check alias id for the give compatibility
>>>>> + * @matches:   Array of of device match structures to search in
>>>>> + * @stem:      Alias stem of the given device_node
>>>>> + * @id:                Alias ID for checking
>>>>> + *
>>>>> + * The function travers the lookup table to check if the request alias id
>>>>> + * is compatible with the device driver match structure
>>>>> + *
>>>>> + * Return true if ID is allocated, return false if not
>>>>> + */
>>>>> +bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
>>>>> +                      int id)
>>>>
>>>> Wouldn't it be simpler to just return a bitmap of all allocated ids
>>>> that match rather than trying to build that up 1 bit at a time?
>>>
>>> Is alias list stable or can dt overlay change it?
>>
>> Stable. If you use an id and then an overlay adds that id as an alias,
>> what should the kernel do? The only choice is ignore the suggestion.
> 
> I didn't play with that for a while but on fpga case you have for
> example serial0/serial1 fixed to hard IPs/PS part and then you add 20
> uartlites or 16550 IPs to PL via overlays and you want to make sure
> proper order for user application.
> It means it is not rewriting current but adding new one exactly how you
> should do that when fixed and fpga parts are together.
> 
> 
>>
>>> What should be the expected flow? Find out maximum number of aliases of
>>> the same kind and allocate bitmap and return it with length.
>>
>> I think we can assume <32 so just return a bitmap in a unsigned long
>> or u32. Use that to initialize a bitmap in the driver. For un-aliased
>> devices, find the first unset bit, use that id and set the bit.
> 
> Ok if this is in driver field can be allocated in the driver and passed
> also maximum len. It should be better then expecting maximum of 32
> devices which ends with max serial31 alias.
> 
> Or at least expect u64 with max serial63.
> 
> 
>>> Anyway if you look at that patches I sent then I call in the driver
>>> of_alias_get_highest_id("serial") which doesn't take care if alias match
>>> with actual driver. It means having information about max alias ID which
>>> match actual driver that would be helpful but I am not quite sure what
>>> should be the flow.
>>
>> I'm a bit confused as to why you use of_alias_get_highest_id and
>> of_alias_check_id. of_alias_get_highest_id is really intended if  you
>> want to start dynamic allocations above all the alias ids.
> 
> I need to get maximum number of ports for passing it to
> uart_register_driver which is called only once.
> And using of_alias_get_highest_id() return me reasonable number for all
> listed serial ports.
> It is not correct because some IPs don't need to be listed in that list
> but it is reasonable expectation for this RFC.
> Even alias bitfield won't help with getting correct number.
> 
> 
> The best will be to get number of devices which match that driver
> because they don't need to be listed in aliases list.
> 
> You get 20 of devices and will allocate space for 20. If there is alias
> below 20 you will use numbers. If there is alias >= 20 it will be
> ignored in probe and number will be assigned based on empty position.
> 
> But this is also no covering overlay cases where others devices can be
> added at run time.
> 
> 
>> I guess the need to match devices is based on each serial driver
>> having it's own major and /dev name. IMO, we should get rid of those
>> and every serial driver use ttySn (with the exception of things like
>> USB serial). Then you'd just need to find all serial aliases. But you
>> can support both with this function. Just return a bitmap of all
>> aliases if match is NULL.
> 
> This will break a lot of things which are stable today.

What if ttySn were simply symlinks and no driver spawns any device of
that name? So the normal NS16550 UART driver would get a new name, but
ttyS0 we could still match for everywhere regardless.

In that layer we could then do the alias mapping and simply honor the
numbers given by DT.


Alex
