Return-Path: <kernel-hardening-return-12320-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELufZ39bBi0KnUFDeMraQ1qJ93y1q7ToBe4WfbDIxMztlTFjEB/Wn3NdozEhuDq5eA1RAHop
ARC-Seal: i=1; a=rsa-sha256; t=1520600782; cv=none;
        d=google.com; s=arc-20160816;
        b=BWszMOuAAN4P2mL7gD//mv0IAV99spKtAzrBtXlhXxkM54JK8T0TUk4P3iRRMeqsm0
         6TlSEGy8jXNV4ifPmbAcjmFeb6NXLQPq2ymsGpxT3lkn1kWYeaSyDbiCe5ccerQVOc/M
         TA6eS38enjUVyBpix1azr+xzoENQ5i9MCVpv+L8N0ZyuhpwIIYjACV6fe86vyDAJElam
         OdO62E8MrpHkQaFJ5KGqNcnP4GtTPd4un7lrclPXbUN52OQUf1ya4tptJ4SmKoJJMg1a
         n1c5NLd00xYIAQzVxkYrjTXd6Hhb5LxT0cEjopWJ6n6Q8EtfMU546/Hy8Q12qi1nVFJ6
         9r5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=cSFBn+HL4BEv+nlhFND57pQ6g+7otxwLy+JvJAQy6pw=;
        b=FG7UEjIPIwOCHy6qkF0xu61GMOgIIA+bRsCuK9GuYWBE0j9BrOVOrfnCfXzOHay79u
         epjWE9v+wjNzPoLrpXYy1zVLEJj8FMVhyGByqd8vXNrca/bLjyl/UFe4C2buy/hqhfkw
         jTulBQv1JsVGy2UZ+0U47XhVURBhttsUv1JTy3MwSV5E9OG9iUFINNxaoFIcmjB8niD/
         TCpqMYsDYnze2O3l+yat34w/Xn+/Df9+mM/+RfY1NeUZ8YhRUjn/tSx8PiQbYSrwce67
         4dp1kxnXjrZ5Cx5+C0IcoJqdxYApUmep9mDBt1bM9naliJ3gEee7cyKWyIE2KeAY7n7x
         2Otg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12320-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12320-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12320-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12320-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5144220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
MIME-Version: 1.0
In-Reply-To: <23757731-bfa5-cb4c-ddc0-04103f9a72e0@embeddedor.com>
References: <20180308172031.GA14541@embeddedgus> <CAGXu5jLjKcYOPxQOV6GO1oaLj1M_K=cFu-kHLLEzP=ZOXaAtfA@mail.gmail.com>
 <23757731-bfa5-cb4c-ddc0-04103f9a72e0@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 9 Mar 2018 14:04:44 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf+4tF4oq5ePsgcpUAQS_M2Vi6b1+J-8D9CVemO-6ve5g@mail.gmail.com>
Message-ID: <CAJKOXPf+4tF4oq5ePsgcpUAQS_M2Vi6b1+J-8D9CVemO-6ve5g@mail.gmail.com>
Subject: Re: [PATCH] rtc: s5m: Remove VLA usage
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Sangbeom Kim <sbkim73@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594390903982064564?=
X-GMAIL-MSGID: =?utf-8?q?1594465485958748985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 7:03 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
>
>
> On 03/08/2018 11:58 AM, Kees Cook wrote:
>>
>> On Thu, Mar 8, 2018 at 9:20 AM, Gustavo A. R. Silva
>> <gustavo@embeddedor.com> wrote:
>>>
>>> In preparation to enabling -Wvla, remove VLAs and replace them
>>> with fixed-length arrays instead.
>>>
>>>  From a security viewpoint, the use of Variable Length Arrays can be
>>> a vector for stack overflow attacks. Also, in general, as the code
>>> evolves it is easy to lose track of how big a VLA can get. Thus, we
>>> can end up having segfaults that are hard to debug.
>>>
>>> Also, fixed as part of the directive to remove all VLAs from
>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   drivers/rtc/rtc-s5m.c | 15 +++++++++------
>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>>> index 6deae10..2b5f4f7 100644
>>> --- a/drivers/rtc/rtc-s5m.c
>>> +++ b/drivers/rtc/rtc-s5m.c
>>> @@ -38,6 +38,9 @@
>>>    */
>>>   #define UDR_READ_RETRY_CNT     5
>>>
>>> +/* Maximum number of registers for setting time/alarm0/alarm1 */
>>> +#define MAX_NUM_TIME_REGS      8
>>
>>
>> I would adjust the various const struct s5m_rtc_reg_config's
>> .regs_count to be represented by this new define, so the stack and the
>> structures stay in sync. Something like:
>>
>> static const struct s5m_rtc_reg_config s2mps13_rtc_regs = {
>>          .regs_count             = MAX_NUM_TIME_REGS - 1,
>>
>> ?
>>
>
> Yep. I thought about that and decided to wait for some feedback first. But
> yeah, I think is that'd be a good change.

Define and these assignments should be somehow connected with enum
defining the offsets for data[] (from
include/linux/mfd/samsung/rtc.h). Otherwise we define the same in two
places. The enum could be itself (in separate patch) moved to the
driver because it is meaningless for others.

Best regards,
Krzysztof
