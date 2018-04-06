Return-Path: <aspriel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523009620; cv=none;
        d=google.com; s=arc-20160816;
        b=YUt0N0vGinL7N7C3XHb4afP6cuaSq9p8Nh9tzHZJwsD9RKqrGtnRdIW8XSHn1Q/XfL
         ShzeTYEJ4n/Ux5eAITmZE0Q/IjdwEDw1nBc3iUqOMJABW75BJjKUHd/2DR7vENcZY+2S
         ujWmqgiBs2n3pVlCwTXUDxwFDoiR57xko+7Eau0prEWwHMvYAI5UMq8y2RSt9uA+fala
         usSNGoWhkUHQkBpQ33cddthVgZNUOkJDgXaAGdxfTK1B3EVBHbCI+CWNYIHa3KnLqkq8
         INqs49lCd+9mzod3N7t36XBOD7/d6K6BM1/aH+u7F+OlgQhQFgab+s0E6qCZsu2UwMUa
         3W3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=pwASrJ9A/NrbfI+h3gksgI4mLo8aULbqpMnP1VVR9u0=;
        b=rDKmOEmpDto2NP728c2WqGZDqIQFqmCTZt+ReGonC0dPcQ0VWUFX8yMe6pk9J1c8A5
         eYp0FsXGrGwrSP+AsaULsgUhn7tkoGKhrdHffkPHt5v1lhZg7DscSf1u47V+4YxemSBH
         boILi6EvTurwMbhY/ImeHQU/4Xo/O+pSc8TdmYdU15xxNvwcZFQWJbiWLqnFOvbrJa+V
         Iy6AMhXz2czadw9OtWKsm01XbWjLUFFBnvxJJR7SO0KF/VL2LlLNakYjljS3AwAqlHHS
         NiNao0840Y1SI0tbGDETVCgEvi86zg10vBrvGC7oTOTvCy/YgGWmkcZBChYqdTn6tu67
         3mCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r4wa4kZP;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r4wa4kZP;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49qZ1Godli3thqA2KcevHqGT9+Ggzwoc28vXLfsaOij2jKx1PBUwz2SVrvwmz88H51yk+Pi5gRi3bWjRsdFbEo=
MIME-Version: 1.0
In-Reply-To: <20180324090446.GA863@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-3-git-send-email-aspriel@gmail.com> <20180323165543.GA21833@kroah.com>
 <CAJ65rDy1UjJ7tEu4f3m8BwnA1qai1iRU3yWfU4qvEE9uLrr5pg@mail.gmail.com> <20180324090446.GA863@kroah.com>
From: Arend van Spriel <aspriel@gmail.com>
Date: Fri, 6 Apr 2018 12:13:38 +0200
Message-ID: <CAJ65rDw-gQKdsokwoC7+NskzTpLq=RLVbLQMh7CDisNFY3o8Uw@mail.gmail.com>
Subject: Re: [PATCH for-4.16 2/3] drivers: change struct device_driver::coredump()
 return type to void
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067781625897?=
X-GMAIL-MSGID: =?utf-8?q?1596991335966359488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 10:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 24, 2018 at 09:50:05AM +0100, Arend van Spriel wrote:
>> On Fri, Mar 23, 2018 at 5:55 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Mar 15, 2018 at 10:55:24AM +0100, Arend van Spriel wrote:
>> >> Upon submitting a patch for mwifiex [1] it was discussed whether this
>> >> callback function could fail. To keep things simple there is no need
>> >> for the error code so the driver can do the task synchronous or not
>> >> without worries. Currently the device driver core already ignores the
>> >> return value so changing it to void.
>> >>
>> >> [1] https://patchwork.kernel.org/patch/10231933/
>> >>
>> >> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
>> >> ---
>> >>  include/linux/device.h | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/include/linux/device.h b/include/linux/device.h
>> >> index b093405..f08c25b 100644
>> >> --- a/include/linux/device.h
>> >> +++ b/include/linux/device.h
>> >> @@ -256,6 +256,9 @@ enum probe_type {
>> >>   *           automatically.
>> >>   * @pm:              Power management operations of the device which matched
>> >>   *           this driver.
>> >> + * @coredump:        Called when sysfs entry is written to. The device driver
>> >> + *           is expected to call the dev_coredump API resulting in a
>> >> + *           uevent.
>> >>   * @p:               Driver core's private data, no one other than the driver
>> >>   *           core can touch this.
>> >>   *
>> >> @@ -287,7 +290,7 @@ struct device_driver {
>> >>       const struct attribute_group **groups;
>> >>
>> >>       const struct dev_pm_ops *pm;
>> >> -     int (*coredump) (struct device *dev);
>> >> +     void (*coredump) (struct device *dev);
>> >
>> > Isn't this going to cause build warnings now?  Are there no users of
>> > this callback function yet?
>>
>> Hi Greg,
>>
>> I submitted driver patches for the 4.17 kernel and from that
>> discussion we concluded it would be good to change to void return
>> type. So those driver patches were dropped. The caller of the callback
>> in drivers/base/dd.c does not use the return value so from that side
>> there is no issue. So my motivation for asking to consider this for
>> 4.16 is so I can resubmit the driver patches for 4.17 if there is
>> still time before the merge window.
>
> It's too late for 4.16 for this, and I would queue it up in my tree now
> but I don't want to cause any build warnings in linux-next from it.  So
> how about I submit something like this right after 4.17-rc1 is out,
> where the function signature is changed _and_ all definitions of that
> function are changed at the same time to keep everything sane at once?
>
> Can you send me such a patch right before -rc1 is out base on Linus's
> tree?  That should give everyone enough time to get the things merged,
> right?
>
> Or is there no in-flight patches to use this yet, and I can queue it up
> now for -rc1 as no build warnings will happen?

Hi Greg,

Are we good regarding this patch. I have assured there are not
in-flight patches.

Regards,
Arend
