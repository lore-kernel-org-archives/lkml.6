Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520337883-2-4773642082822496686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520337882; b=PuAp3nx+QxykUGBTJ52YDRQVPbLRvxBDPNwAo8DcCeIGgvf
    iw1QmqjNiHN4HfAT6EFZmuBigS2ICmdZOHQ4cVWNe3KeQGsTmrJ1gCBwxpMRRZwu
    IJ4sg858jdmIsWKpqB9pXIcZWcxoylQ4ENncWFziAy2wijXRx3WJpplIXBxWZc29
    GOTrOvJV6fimeGqVASl5Dj7rRaB1hPFqWEz3LMjTfG2FC7gV6H1O0gyyHsWh+5m4
    UAa2isBMwVsDiMMuqqKMzjpZAWzWEi5RuXdtWZlBDM13h2BjxmpZQxiLydcbnGVT
    Pr/U6MXuAFZmC6nF1L1avGGcLZbIIHmdB+MuByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520337882; bh=z
    jsWYK9HiOlbG/CZ3rZjuOKqY2DbQlMgE5wbSOrcrI8=; b=dgiNZ4TPpLe3c0ZZq
    d2txqVHK7cuWKvSiAm2xqHChg4i4Be/sp0a8NUpMQq+6R/uMjpGw0PevarpnGn8k
    F1EmOON8ACTPd3IqDCsDtsTTq3xIkldE7TwAmTJJpBbNJERYnByFLDEHpCm1c4SM
    XKeYaDlNkRr7vvWUz3J4iDrkdAqm6NshkGpeu5e4nucsiJ7o+aB6OblIFvxg/JWk
    sSif3jBcuJvwKpibPPnSbrvcvWcStBJc2iIWzBl4C7KEIcmRWOQ7NqqWwuEjfSuA
    qrxh+RTp25JEdY2cyh8I3oy5UfTE4ugPCdWeXQDIvxJ/wpGDWg2vNvB4L2mOds3x
    t5ysA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pfTVlBHS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=abyFhy2e;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pfTVlBHS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=abyFhy2e;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv7jKjn7pgT9n+E1OkATuGhijAkfzSVPHdcHT+uaT0P8r61xvpiaZoZncBsZM/OoRRgPJPfhv03KPZkZ7PJRRE=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803052203001.2763@hadrien>
References: <20180304223205.GA31416@seema-Inspiron-15-3567>
 <20180305100345.v6ajs7vdgzmwu5x4@mwanda>
 <CA+XqjF9tBqpgp7ymQOAWeJHm1hPd6w01u3ZVS8ozq4JuoBNSEg@mail.gmail.com>
 <alpine.DEB.2.20.1803052203001.2763@hadrien>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Tue, 6 Mar 2018 17:34:32 +0530
Message-ID: <CALrZqyORX5j74apDv4+6UP4iz6v07gtN+06_M-FMFeO29ODB4Q@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: irda: Replace printk()
 with appropriate net_*macro_ratelimited()
To: Julia Lawall <julia.lawall@lip6.fr>
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
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 driverdevel <devel@driverdev.osuosl.org>, Greg KH <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 outreachy-kernel <outreachy-kernel@googlegroups.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 2:33 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Mon, 5 Mar 2018, Arushi Singhal wrote:
>
>>
>>
>> On Mon, Mar 5, 2018 at 3:33 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>       On Mon, Mar 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:
>>       > Replace printk having a log level with the appropriate
>>       > net_*macro_ratelimited.
>>       > It's better to use actual device name as a prefix in error messages.
>>       > Indentation is also changed, to fix the  checkpatch issue if line is not
>>       > exceding 80 characters.
>>       >
>>       > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>>       > ---
>>       >  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>>       >  1 file changed, 11 insertions(+), 11 deletions(-)
>>       >
>>       > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>>       > index e6648f7..200fe5f 100644
>>       > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>>       > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>>       > @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
>>       >
>>       >       priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
>>       >       if (IS_ERR(priv->tfm)) {
>>       > -             printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
>>       > +             net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
>>
>>
>>       This should probably just be deleted.
>>
>> Hello Dan
>> Why we should make this change?
>> According to me it's use here to print debug message.
>> Wanted to know more about your thought on this.
>>
>>       >               priv->tfm = NULL;
>>       >               goto fail;
>>       >       }
>>       > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>>       >       keyidx = pos[3];
>>       >       if (!(keyidx & (1 << 5))) {
>>       >               if (net_ratelimit()) {
>>       > -                     printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
>>       > -                             hdr->addr2);
>>       > +                     net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
>>       > +                                         hdr->addr2);
>>       >               }
>>
>>       The "if (net_ratelimit()) " already means the message is ratelimited so
>>       it's net_dbg() ok?  I think so, but I've never looked at this before.
>>
>>
>> net_dbg() is an implicit declaration of a function. So we can't do this change.
>
> Perhaps you can add the header file that declares net_dbg.

Hi Julia

There is such header file which declares net_dbg.
We can use dev_dbg() for all struct device object.
We can use netdev_dbg() for all struct netdevice object.
For net subsystem when there is no struct device object we can go with
net_dbg_ratelimited (preferred) or pr_debug.

I have understood this from my readings. If I am wrong somewhere
please correct me.

Thanks
Arushi

>
> julia
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1803052203001.2763%40hadrien.
> For more options, visit https://groups.google.com/d/optout.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
