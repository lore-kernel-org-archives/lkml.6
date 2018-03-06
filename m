Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4155484-1520328210-2-16982046042088112827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520328210; b=h9gTxZTHesI9Y1chQPXRuUJfFBw8757nrHHXOph6SEP463u
    aTbKPmuW5A5IxdKO40aaIZIBYpoKOY2RPnhmIwtPjGyMs5rgKZ39TNyQPhFEryms
    MJuORor9jEl9K7nvIn5E4xgMt+UnQc7XsfbcmSGKXzXiou5FUY+kXIvcMgu7b3nA
    OTDfL2hWN+Td2JcBXB59dg9BrJFzNHQu9qaaq6qSDg2tT9mFdCHyNH8GpYlmGGQY
    FcNBSO1QOoM3FfGAsHeIafQtLuvYNf85wlcJ6c7dUKvVYKqhL3hNpsXqQlztOrBU
    wG0xHnZf353xjAWABze1UxgtDLMova3nVkwsXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520328210; bh=D
    0ZJQlwo32UwA44N8MMJqOWq/j8wIsRrbdCteK0eOmQ=; b=fFEVSA+1zSINU3Jcx
    1Dhy+IEjqUJjR0jKdH1dV0qMV+EaCIVRjyk7V6+9yKqDruuPBPCWNvKYVaGDJLFP
    t3Kl8cINwcQvZbqT2sNqDon2IJCqjGGkFWkbx6/C3G7F+fyHnES30lOGe44mveA6
    7HNsm8FsbJ5ZjR3VW7mN1rjLIlJAFLw/HXZoSdsSnFExnHLdqMa4Sd7ZsIdTyrNT
    40gmuMIa9P72Nq/5FFgpW+IkryLRSuUcgm9OROcDMSkaTNO0pHLtJlY0IKwVbz/g
    B4eJwq7b/4xZueo/fZN3mJlXHBY4JcjD18tXKPgo3k2byB+DK4XKVUpxuVmbNru0
    lmf9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt1YldNjHrLGsfWLoHjUvKvyp0pNStVffzgbPBBnTTd/c0/hpZDzpGPLJA6TZppcNrJ2Z27cIlPcuw0KVw54c0=
MIME-Version: 1.0
In-Reply-To: <20180301162130.GB15087@kroah.com>
References: <20180224075835.11618-1-quytelda@tamalin.org>
 <20180224075835.11618-2-quytelda@tamalin.org>
 <20180301162130.GB15087@kroah.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Tue, 6 Mar 2018 01:23:18 -0800
X-Gmail-Original-Message-ID: <CAFLvi20e+D4984vypj7nVECFxh_AKVwGWTqCqfyFYJ9AV=Rvdg@mail.gmail.com>
Message-ID: <CAFLvi20e+D4984vypj7nVECFxh_AKVwGWTqCqfyFYJ9AV=Rvdg@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: most: Replace calls to BUG_ON() with
 WARN_ONCE() and return.
To: Greg KH <gregkh@linuxfoundation.org>
X-Provags-ID: V03:K0:Xom5ilAa0SykA3UnXJ2Hff4yl9nQYxpksj1sEIMW/H0nlxaBOjq
 5vwvzfl26E3cr7o9fjccnVRVfffAaYIFTFtdp3lZPR1kZHbvxrkJsto9zVch1gMCjRNg4Ex
 1eKaTM9q/KOAMMqu1F4s+w95bcrdl6as849AqyvKQdl9Ro6m898Krlua7S58qvb+iPq6na0
 g00gsDoFxIXx9mvVrlVSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WNxFO1k8zzg=:CXT2sire6l2WTmPcmmrF2d
 gNiOdWlXKMf1CFI9T3NMovLUQmB4cU1HzYUCPEplYOUVA8u2nOZTgKvgGpBExko85jZubzndP
 xqjmuzOCY8XU/B8QMuhJZ+tN0fNep8tEGZnngx99XHzyaYX6mgfABYvpUYPr2u/+CrbGROzXY
 XlqTMqSzFh2gWsQA5QqQyIl9bo+3MSiuGD3QgJi4FrKU+mRfpbrWuUbJLkH2gRWJVjYZUKgud
 omMHGcW0+iCJ09DPnH6bNcIBC3KjA5hb94HkIjsFKLUjKI7tuwlOatAg6W7mKHrtzhtBpA0L3
 5bxbRUcz494yw1qexP5lU+NRXvEI8azF6eWDGNQHxCMyZGJVVWk+D7u4ITkN45F2wrxL26Rhx
 FSBZiDCX5V9XCb+BOpe8Silovk/wHvdOQY6Hbz8wsHyCcyYs2A+4OvjhnNTN1y1MQKY2XhoXI
 FX6Zm3eLYs1rZDcd613xQGsky2LNuYcaVN8jvQF/MWic8kjRmWdbi90wfXjoRiBbZwWcXKzMz
 aPd9Oji+66Wj6r9q+ZD+QlCDf4aovcBCqMeJS6+dKcCK7qVxzg6HpjMU2/3LUvVnQNgUSYHxp
 slueTC5VO6uVms/hAmFNogWxI8G5vyr5BTZ6vnmPMfcPIiHXyD41L/BTu10P3SctxgOsymh1O
 NCECRswV0EoLySMg+oJZqd1l+YgCa3cVTfRnrPruR8hcybjAHmPP0xJcZzkdE2yNrgY59tv2O
 UJ7IwQ7/VSt7K57g77IPC0/1XtyFleHm1FZqOsaVCmnFad+yCgaRpfojT7w=
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
Cc: devel@driverdev.osuosl.org, christian.gromm@microchip.com,
 chris@engineersdelight.de, linux-kernel@vger.kernel.org,
 Michael.Fabry@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Are you sure this will work?
Well, my goal was just to replace the code that could crash the kernel
and let somebody with a better understanding of this particular driver
write the recovery code, if necessary.  It seemed from context that
the BUG_ON() calls were being used like assert() though, so I assumed
there wasn't really much recovery to be made from that problem.  If
you feel this doesn't improve the behavior of the driver, just drop
the patch.

Thank you,
Quytelda Kahja

On Thu, Mar 1, 2018 at 8:21 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 23, 2018 at 11:58:33PM -0800, Quytelda Kahja wrote:
>> Replace calls to BUG_ON() used to check for NULL pointers with WARN_ONCE()
>> followed by a return.
>
> Are you sure this will work?
>
>>
>> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
>> ---
>>  drivers/staging/most/core.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
>> index 18157dd80324..3f65390a6e17 100644
>> --- a/drivers/staging/most/core.c
>> +++ b/drivers/staging/most/core.c
>> @@ -916,7 +916,11 @@ static void arm_mbo(struct mbo *mbo)
>>       unsigned long flags;
>>       struct most_channel *c;
>>
>> -     BUG_ON((!mbo) || (!mbo->context));
>> +     if (WARN_ONCE(!mbo || !mbo->context,
>> +                   "Bad mbo or missing channel reference.\n")) {
>> +             return;
>
> How is the code supposed to recover from this major problem?
>
>> +     }
>> +
>>       c = mbo->context;
>>
>>       if (c->is_poisoned) {
>> @@ -1001,7 +1005,7 @@ static int arm_mbo_chain(struct most_channel *c, int dir,
>>  void most_submit_mbo(struct mbo *mbo)
>>  {
>>       if (WARN_ONCE(!mbo || !mbo->context,
>> -                   "bad mbo or missing channel reference\n"))
>> +                   "Bad mbo or missing channel reference.\n"))
>
> You did something different here that you did not describe in your
> changelog :(
>
> thanks,
>
> greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
