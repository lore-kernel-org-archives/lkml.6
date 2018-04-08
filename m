Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2548284-1523200980-2-12678287690820748952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523200980; b=uMatd5yIzIV6uVb3WOgUdFJvf/RYfO09FVeqXAvlVCjME8tp6h
    rSndvTB5337GGAodXvRiy8HxnZ033AHQgxqTDSgRZQ40aNJQG2rbGVICvCy0f1mq
    aLVgMAXLFstJv01tT/Gj/97tWzy64y/3wa1viBROqjFvxaWRXFdG8OFg4BBf94ws
    9Ha10OrOZwyYBJqeehhy5z+KF0bzdH+wl1k9RwrOcplypbaxBditBuN69UzC/VqZ
    w0oJHYTQM46T+eJrjHigzk8y/X4NveSkvPVA1YFcX40AB/klffY8PGuQzScuY2GD
    wKsh65FQRXrHi4UQKdeY1Kkfhxt7W63ENzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523200980; bh=aw3hd
    2DpDyb0JA4IbGFTblP4gwhvw3kPmynhejkMygw=; b=qljQQMR+NhHQI3eiPG+vw
    uJTmFKrDMGcGjPslwwlewYoAJADdRlIy9GdYhptMQGEPlu0TGaWFf1+qlNDa4z0I
    DSns+UG9gygfY4G+nFQiqbrFH1bMveEbXPZB3zA1+fPS02Jk8XcRHVDlSATecIZD
    Zdh5U+UX9JyNq31aMmc3WWUiN69pHHnK0ZbuxTbzFZ9ZOzxjUW4enzT+wJuKDeJy
    2BcOyq/eXS/1HjzH0jDBA2QkZYG7AGzttgsweV0HPJ9peDzYiNlW5OUCqo6zCAru
    bZqxYkoYUhB7qGlpW66ZsyIyO+Cx6sV10yyFNf7Pj0gLYspYPx1Vx/obJ/hLyX3/
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAJMp2l7lj/utv6sfS9u9CQiT74HH/3E01siK3ih8jdwe8FQDYzb1oATNZcWNnwOZbw9DYGXemvYi+60jUVi+uJCiHfE7wunC3ilVKW6wHicmX82jG6n
    34ak+NMGzBytK5cyk99EYlJVWDWY/EaIlAS/IB6tpG2OKzfi92wS/s7EsBUnzOUO9cz8CGNkzICddo+b47D3p9BKxiK1CMXVZTkf/J3ZR0lAPQkPqhbbuqhr
    MR2CNEaYlO/Ivjz+gF7YtQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=VbyBoA-nuDIoTskZjREA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 Marcus Wolf <marcus.wolf@smarthome-wolf.de>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <68bb0145-b144-b442-7ff3-c6080e44f377@smarthome-wolf.de>
Date: Sun, 8 Apr 2018 17:22:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325130944.GU31333@gavran.carpriv.carnet.hr>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Luca_S=c3=b6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Valentin,

like promissed, I finally had a deeper look to your proposal with
kfifo_avail and your patch from 24th of March.
In principle, I think it is a very nice idea, and we should try
to implement it.
But there is a snag: There is no guarantee, that kfifo_in will
only fail, if the fifo is full. If there will be any another
reason for kfifo_in to fail, with the new implementation there
will be no handling for that.
But I think the chance of such an situation is low to impossible
and the win in simplicity of the code is really great.

Regarding your patch, I did not understand, why you did not remove
the mutex_lock in pi433_write. Wasn't it the goal to remove it?

Below find a proposal of pi433_write function, I wrote on base
of my outdated (!), private repo. It is not compiled and not tested.
Since there is no more handling in case of an error (as well in the
propsal as in your patch), I removed the error handling completely.
I only do a test to detect proplems while writing to the tx_fifo,
but (like in your patch) do nothing for solving, just printing a line.
If this unexpected situation will occur (most probably never),
the tx_fifo will be (and stay) out of sync until driver gets unloaded.
We have to decide, whether we can stay with that. Like written above,
I thinkt the benefits are great, the chance of such kind of error
very low.
What do you think?

It could be discussed, whether it is better to return EMSGSIZE or
EAGAIN on the first check. On the one hand, there is a problem with
the message size, on the other hand (if message isn't generally too
big) after a while, there should be some more space available in
fifo, so EAGAIN may be better choice.


static ssize_t
pi433_write(struct file *filp, const char __user *buf,
		size_t count, loff_t *f_pos)
{
	struct pi433_instance	*instance;
	struct pi433_device	*device;
	int    required, copied, retval;

	instance = filp->private_data;
	device = instance->device;

	/* check whether there is enough space available in tx_fifo */
	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
	if ( num_of_bytes_to_store_in_fifo > kfifo_avail(&device->tx_fifo) ) {
		dev_dbg(device->dev, "Not enough space in fifo. Need %d, but only have"
						   , required
						   , kfifo_avail(&device->tx_fifo) );
		return -EMSGSIZE;
	}
	
	/* write the following sequence into fifo:
	 * - tx_cfg
	 * - size of message
	 * - message
	 */
	retval  = kfifo_in(&device->tx_fifo, &instance->tx_cfg, sizeof(instance->tx_cfg));
	retval += kfifo_in (&device->tx_fifo, &count, sizeof(size_t));
	retval += kfifo_from_user(&device->tx_fifo, buf, count, &copied);

	if (retval != required ) {
		dev_dbg(device->dev, "write to fifo failed, reason unknown, non recoverable.");
		return -EAGAIN;
	}
	
	/* start transfer */
	wake_up_interruptible(&device->tx_wait_queue);
	dev_dbg(device->dev, "write: generated new msg with %d bytes.", copied);

	return 0;
}

Hope this helps :-)

Marcus


Am 25.03.2018 um 15:09 schrieb Valentin Vidic:
> On Sun, Mar 25, 2018 at 03:00:09PM +0200, Marcus Wolf wrote:
>> Unfortunaly I can't find the time to have a closer look on the code this
>> weekend - still busy with tax stuff :-(
>>
>> Idea sounds great. I'll try to look at the code and think about it
>> during Easter hollidays.
> 
> No problem, there is no hurry. But please do test the patch I sent yesterday:
> 
>   [PATCH] staging: pi433: cleanup tx_fifo locking
> 
> As I don't have the hardware this is just compile tested now :)
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
