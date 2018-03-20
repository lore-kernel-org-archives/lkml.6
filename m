Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1722532-1521561025-3-16503213193745672714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521561024; b=D10Qrl3Nn5rPmfFboy882BHtxDCJCeEYzSHTAKndRHb47cu
    d3nJ0y0X8bmlousKW0vhDjg91uGUxl8bYyb54KNVcyNLoyIf/Z7x67qlk0FPoNZY
    0qeuzytPowk/8gPLaf6Rdim+brVXSnxZndVTVbpHwic0dmfe5PheFNC/UMvvuMW0
    QTHxWipM3MCtWpiK4w8xPr6fK5jFEd37t31awi9XmJur7KSHXrkBV+EcgpxwAPeZ
    35n8k6vE0zodZOITCDuDHIbY3hvw2xQ3hzu+zbw6rz63zizRyCfPRzHvcKXuwvgJ
    1EhXLeYWtVQtgiuHZfNEV5tdMpBojLhHTKLNBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521561024; bh=0
    9XiihRqxGHCUdKw0RvB5So4NKewShfQjNt5uFkRwDU=; b=Oy24w2ZOVr5K39z89
    87AVNEV+jxluUWUBZv8g4ZJLvNsQWseVJnqlxBl64rPxaMVgQtWPk25liQuhE5CU
    dv/V6Eb5BWFtrOSiBRC7gKLxdbN5KkDoUV/Ewd3bHbuC1lPFXUDibe3pBxCU79MN
    JBw9sw4v/u3Hg1Tm7ZPQJR9p9CNr4LYtcZv43iNb6GGV6ugmhQyMgUWgn4I+oBuL
    60WpMhhTiM61lEU8RgLYnO8dBFAkOYWCWBifUsP2eHVcCOngwaYuK4Suhr2J5ObT
    vb4zgnJMZNd7VbiMQGIpq+CDPDZp56xdCjy2ZQMDwkB2GniwvKnQ5lImkQ9p/HHG
    g/eRQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ScMbsSd9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GidsuIDf;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ScMbsSd9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GidsuIDf;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs7VqxZ0PIO4gOittWqKZ6XIcTQZd9n1yhKfGxpql/DcnR6mLT3tqIHplUjXQgpNwZFOYsLFwStdZnz8osW2Lo=
MIME-Version: 1.0
In-Reply-To: <87lgena72y.fsf@notabene.neil.brown.name>
References: <20180317091530.GA18271@tanglefoot>
 <87lgena72y.fsf@notabene.neil.brown.name>
From: Justin Skists <j.skists@gmail.com>
Date: Tue, 20 Mar 2018 15:50:14 +0000
Message-ID: <CA+H6UkV+gorXdOWBL=RUuh_+gGoMRS1zThLzQRfFUCRB3=qpxg@mail.gmail.com>
Subject: Re: [PATCH] staging: lustre: Fix unneeded byte-ordering cast
To: NeilBrown <neilb@suse.com>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Patrick Farrell <paf@cray.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 March 2018 at 01:06, NeilBrown <neilb@suse.com> wrote:
> On Sat, Mar 17 2018, Justin Skists wrote:
>
>> Fix sparse warning:
>>
>>   CHECK   drivers/staging//lustre/lnet/lnet/acceptor.c
>> drivers/staging//lustre/lnet/lnet/acceptor.c:243:30: warning: cast to
>> restricted __le32
>>
>> LNET_PROTO_TCP_MAGIC, as a define, is already CPU byte-ordered when
>> compared to 'magic', so no need for a cast.
>>
>> Signed-off-by: Justin Skists <j.skists@gmail.com>
>> ---
>>  drivers/staging/lustre/lnet/lnet/acceptor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/lustre/lnet/lnet/acceptor.c b/drivers/staging/lustre/lnet/lnet/acceptor.c
>> index fb478e20e204..13e981781b9a 100644
>> --- a/drivers/staging/lustre/lnet/lnet/acceptor.c
>> +++ b/drivers/staging/lustre/lnet/lnet/acceptor.c
>> @@ -240,7 +240,7 @@ lnet_accept(struct socket *sock, __u32 magic)
>>                       return -EPROTO;
>>               }
>>
>> -             if (magic == le32_to_cpu(LNET_PROTO_TCP_MAGIC))
>> +             if (magic == LNET_PROTO_TCP_MAGIC)
>>                       str = "'old' socknal/tcpnal";
>>               else
>>                       str = "unrecognised";
>
> This code is almost completely irrelevant (it just choose which error
> message to use when failing), but we may as well get it right and I
> cannot see why your change is a fix.

I admit that the change is trivial, and, in hindsight, the word fix is
a little "strong".
The rationale was that the if-statement, as it was, probably wouldn't work as
intented on big-endian systems.

I chose this sparse warning to test the waters, as it was an isolated change,
before I thought about proposing a bigger change: There are quite a few
sparse warning in regards to struct lnet_hdr with regards to __u32 vs. __le32
(etc.) restricted castings.

> I suspect a more correct fix would be to use
>   lnet_accept_magic(magic, LNET_PROTO_TCP_MAGIC)
> as the condition of the if().  This is consistent with other code that
> tests magic, and it is consistent with the general understanding that
> "magic" should be in host-byte-order for the peer which sent the
> message.
>
> Could you resubmit with that change?

I agree that your suggestion is a much better fix.

As Greg has already accepted the patch in question into staging-next,
would the correct course of action be for me to submit a new patch with a
"fixes" tag based on staging-next? Or would Greg prefer to drop the
previous one for a fresh v2?

Regards,
Justin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
