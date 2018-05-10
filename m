Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525988989; cv=none;
        d=google.com; s=arc-20160816;
        b=I35UhPg/zsLlHh9D2QCPDNaU7BJLwu+wyxjMrCK34ZBx5uopodJN9c5SQVuvUlTyad
         pXSjEte3sP4JH/kJJ2aouDG0YglPTqanLlIOSXjdd9F836h58K0+JDPqGflScKVU9SHD
         PjHZEa/U0OfdmHbkGVCDCapP/9BvP3brTIvzXqPwkvBh2G2HwSlW84dWJLyhthFoL1ko
         yaoFY2I47F0dMV9TLkMSSo74maAmXxm5J0LDuGI8Dtn1aT0PlTLfy7tSTHGGZNsnrAtt
         Lk3DbynxZczSbAoTgKUbz8B41nmQOo711/CQeybMMzgrTLD1DM+KFI5NJGbHJ6SYcMB7
         cYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DSFWYJzFM6jJ60Yq/XuiwoRm/dSecebxbD5Jpc9pygw=;
        b=grfCcGNO1KQTYupOrH7yx7GpUWC4dYJiroN4d8mStoIO5XeNFF5gM6D676iPWqRbKR
         M74tv9Sj90ugJrLWE8s71P8EBTZQNkWbGNx4yxLpK7Xj7Mf45f9SpXKnL3bDOU3Hp7B0
         EknhODv6NVukNY6gJQTU7pJMppHUvK91ZPxJGWkhT15Go4OsIA3WfTAsVm5iALn+sPRX
         0R2zei/e/QJbM6NzHa19HM8le8H/WYRATAxAdhPNsof7kjhifsApopVNP3hyf7QEdQ8t
         Hq9JI//k3lXNYxf14iPJvvotjlHVN5m6yuzf1WF27jH9YcMAZ5BYXhF3GOAdEELASfFO
         XR6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JcO4wZ3O;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JcO4wZ3O;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoT3s7JlQPfCCkVmX+Z9FhMHMaVpnAQm72/jTKhE9LuVeGjjkB4eyuvdWBmTYbdENZTdbOHCIClJry7sO7dJHU=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LwxT6+9U-qCcYEVsPUeL+eVG_aSUZzEM7spwHGb7AQgQ@mail.gmail.com>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com> <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com> <20180509073754.GG711@sol.localdomain>
 <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
 <CAF=yD-KGO=+=j3yTr4H8cF_WH3RGtnyMDgYRzd7da-r7D=U=GQ@mail.gmail.com>
 <CAF=yD-JPmU-q1iUoxtmyQa4BM=fU3CMR3BUDGNMg-4v8=2_deA@mail.gmail.com>
 <e7be4d14-be04-c40d-82ad-2050876f9ce9@gmail.com> <CAF=yD-LwxT6+9U-qCcYEVsPUeL+eVG_aSUZzEM7spwHGb7AQgQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 10 May 2018 17:49:08 -0400
Message-ID: <CAF=yD-+PQqA87y+5614d=q3mhRGvh=GNgu1h9AFNepBHxaPZQg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>,
	syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
	alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
	Anoob Soman <anoob.soman@citrix.com>, Chris Wilson <chris@chris-wilson.co.uk>,
	David Miller <davem@davemloft.net>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, Mike Maloney <maloney@google.com>, mchehab@kernel.org,
	netdev <netdev@vger.kernel.org>, "Rosen, Rami" <rami.rosen@intel.com>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, syzkaller-bugs@googlegroups.com,
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1600115430776330898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 5:05 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Wed, May 9, 2018 at 3:36 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>> On 05/09/2018 12:21 PM, Willem de Bruijn wrote:
>>
>>> Indeed. The skb shared info struct is zeroed by dev_validate_header
>>> as a result of dev->hard_header_len exceeding skb->end - skb->data.
>>>
>>> Not exactly sure yet how this can happen. The hard header length space
>>> is accounted for during allocation as reserved memory. But,
>>> packet_alloc_skb does call skb_reserve(), moving skb->data
>>> effectively beyond this reserved region.
>>>
>>> It may be incorrect to pass skb->data to dev_validate_header, as that
>>> does not point to the start of the ll_header anymore. Still figuring out what
>>> the right fix is..

The following resolves the issue.

packet_alloc_skb already calls skb_reserve(skb, reserve), so now
the network header should start at 0, not at reserve.

If SOCK_DGRAM, dev_hard_header() calls skb_push for the link
layer and returns this offset.

If SOCK_RAW, we should do the same and use the reserved space to
write the link layer.

Now behavior is the same as in tpacket_snd.

@@ -2898,19 +2911,26 @@ static int packet_snd(struct socket *sock,
struct msghdr *msg, size_t len)
        tlen = dev->needed_tailroom;
        linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
        linear = max(linear, min_t(int, len, dev->hard_header_len));
        skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
                               msg->msg_flags & MSG_DONTWAIT, &err);
        if (skb == NULL)
                goto out_unlock;

-       skb_set_network_header(skb, reserve);
+       skb_reset_network_header(skb);

        err = -EINVAL;
        if (sock->type == SOCK_DGRAM) {
                offset = dev_hard_header(skb, dev, ntohs(proto), addr,
NULL, len);
                if (unlikely(offset < 0))
                        goto out_free;
+       } else {
+               skb_push(skb, dev->hard_header_len);
        }

        /* Returns -EFAULT on error */
        err = skb_copy_datagram_from_iter(skb, offset, &msg->msg_iter, len);
