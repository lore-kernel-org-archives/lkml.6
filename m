Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x2264VQUa0FHs+aHH6QbJIxr4LBB0S53QbOX/Rvl9W6q76nVXf5TUJ1Xx+zaO/Fz3CPw7O2tX
ARC-Seal: i=1; a=rsa-sha256; t=1518688798; cv=none;
        d=google.com; s=arc-20160816;
        b=CKPqSiCLdmctdgk/3uj16Z7X1pxbjjj1hiEJFghpCQxzHG4eke1l/9YJZn6e/JFlmw
         82hHfNryCsq8rkfvih4xsbYAxl1N3Emb8ySwxX6uQgBc7jLE8c3Ydr9DG1CL90yfTbGf
         gUE/JrHXC3hiTCBfoxw/dUbZhf8xmx0XZYNLAjv4Zz4qwL6RS4Q4qLrk+IIo+rkfSeT5
         hRdrPw1DozLWUiPKeJ1aADqBoNIsW28RHSya9OcJgDg0wgjrMK7ns2lAWO5WriQ11miR
         jAZDNLZRjDg1O+pDwgmha0XQOOIOjmdEJIYrNQdC3zH+vNBgL+RtBJfA2l2I8KvnL7bE
         RkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=WixgscDL7Nu6UdXMosLG5+79QITbJe83UNi/LSQYJ9k=;
        b=M3AJNswFXlWMijiZiD/W0TcXk4KaVi518CXOndxrPh6SdUX/ziuaV+qv9ENnxu5GLK
         qlKhxnS+HgxYHBBO/SHLUWqA6KvkzaqwIq+kamT6MWL7kR3tJnqTL2P6M6fvZ/5jEe1y
         uNclkUKjF6lu/tUz+YoOv5tpD16X3VX77eY4L9XUNzL3S2AMBWBz+cyeTrpNipSpkwKP
         J/BTFIoVfKfKopL6Xs3S0SrumKPQhuwPeMfVzhtLPm0UMTkvfIyfJczZIjvb7P5mqjct
         um8Fk+sSr8AtRtvjZUOLY/GjXU87e4mjN0qgcn23qoG/RaKTyWs3AKfzSfAjrxjD1PZ8
         Mbuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/20][RESEND] firmware: ARM System Control and
 Management Interface(SCMI) support
To: Alexey Klimov <klimov.linux@gmail.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
 <CALW4P+LPiYSOCKW4iS6OwK9S=M3aCP+X6QNnDkycY5TYQsCb5A@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <ad072d94-84fc-cd07-a4de-4fe66ca47b05@arm.com>
Date: Thu, 15 Feb 2018 09:59:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALW4P+LPiYSOCKW4iS6OwK9S=M3aCP+X6QNnDkycY5TYQsCb5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221911183430118?=
X-GMAIL-MSGID: =?utf-8?q?1592460625405560682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 15/02/18 00:09, Alexey Klimov wrote:
> On Mon, Feb 12, 2018 at 6:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi all,
>>
>> ARM System Control and Management Interface(SCMI) is more flexible and
>> easily extensible than any of the existing interfaces. Many vendors were
>> involved in the making of this formal specification and is now published[1].
>>
>> There is a strong trend in the industry to provide micro-controllers in
>> systems to abstract various power, or other system management tasks.
>> These controllers usually have similar interfaces, both in terms of the
>> functions that are provided by them, and in terms of how requests are
>> communicated to them.
>>
>> This specification is to standardise and avoid (any further)
>> fragmentation in the design of such interface by various vendors.
>>
>> This patch set is intended to get feedback on the design and structure
>> of the code. This is not complete and not fully tested due to
>> non-availability of firmware with full feature set at this time.
> 
> If it's not fully tested and not complete (I read as this patch set is
> not ready to be merged), then maybe it's better to mark it as RFC?
> 

Sorry that's copy paste error, will drop that. It was valid for onlyRFC
version posted long ago.

>> It currently doesn't support notification, asynchronous/delayed response,
>> perf/power statistics region and sensor register region to name a few.
>> I have borrowed some of the ideas of message allocation/management from
>> TI SCI.
>>
>> Changes:
>>
>> v4[6]->v5:
>>         - Rebased to v4.16-rc1
>>         - Updated all the gathered Ack/Reviewed-by tags(which includes
>>           all the drivers using SCMI protocol)
> 
> You still didn't comment on all questions to previous patchset.
> 

Anything else other than the below one ? I addressed the lock issue you
mentioned and asked for suggestions on the delay thing.

> For example,
> https://www.spinics.net/lists/arm-kernel/msg626719.html
> 

Sorry I thought I responded but I clearly missed it.
I am not so for the module parameter as I did try and never found it
useful for debug images of the firmware. Any other use case you have in
mind ?

I think it's better to keep it simpler, I am thinking of even dropping
it as a configurable variable like max_rx_timeout_ms.

-- 
Regards,
Sudeep
