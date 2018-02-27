Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-893183-1519716767-2-2900689586289826298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='nl', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519716765; b=SVq7Ihlor4sDXl48EWEtEt8n6rJhlBGDquj2INvg6jtk2iC
    dz88eLKGRcJLWKH9uvh+ND/w4UwBjqc2pOPymbEHgZrZeo4UFtD1SK6Anc0S4wJ1
    hzK7afdbcQn4Qt4gbv/OUjQaRil+ZBiFvhwQUhOkmYD63taCxLyXKMxpWEGqW/dV
    IGz79aXRkLcnKN+UB61mw5YY3Q/i2avFHC884mwqkhXuZeiatOvCnfxRNkwpc48p
    9qjPIrqCgicvJEHlJkCv5sJXWlQ9G5q2YRKmnwbh6nI8W9Uv8B+pd1KYKMTgI/Oz
    z7ZaVrrBRZIqWMf6YEpjkIDCVXE8N8K7Vx4WaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519716765; bh=t
    xnRGe7fOB6Dp/4yD/kPrX7Ta4z+FP+rCS6ODWZfwbk=; b=MxY8OM1OlNx9yAv27
    AxLPtEKbP9cdZBm+SGmWxoEVmcSIRgK0R0OmZQdG8Q9WRu9703ZCQbXqyEdhh/6z
    HPlaiZDAq6gc3SrN9SugiLV5IZdktGa2eU+drY48DFCMAsBBc82S8nMVvnEzMtLZ
    aXKzTzYIep4P1DQ3m/M+R4qxLonSLhWUDeY1hVZioTgM7fVzD64Sh9hYYup57JuL
    WKOFF2ksjKSzm88zGEoQSqcicswJ20o9gAzSwfgRUdjn9z1fbC3O5mnN8/ws8Br+
    A08HSE0shFTAC9fRr3zp2eR2ZTwvlY+yOr7RAsE7zvR1xkfDOPjw7FsGkQZ8aW9Q
    Azx+Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xs4all.nl;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=xs4all.nl header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xs4all.nl;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=xs4all.nl header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH v2] Staging: bcm2048: Fix function argument alignment in
 radio-bcm2048.c.
To: Quytelda Kahja <quytelda@tamalin.org>
References: <20180219072550.hz4vpomsaz2ajrnm@mwanda>
 <20180220065304.8943-1-quytelda@tamalin.org>
 <cb62e915-eb9c-9252-1f0a-cc85c8ea3530@xs4all.nl>
 <CAFLvi2357U3HAt3mXDdNdZs4QA9mqWntTny4XyvtSfV2hu1dmA@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7c9787b2-bad3-21d9-f726-e171d9af940d@xs4all.nl>
Date: Tue, 27 Feb 2018 08:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAFLvi2357U3HAt3mXDdNdZs4QA9mqWntTny4XyvtSfV2hu1dmA@mail.gmail.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfITh+EFjYhMyjyviCa88Ouq2GEQcq4porkmZ8IuZtqWvIpUZOIboYwoanseN+GFQGVOk77dvyov5/nQlU2FUggAGChCzdwoPwnFTpHb4EWGUT+hoELXa
 MiJ16snWXwqTPZVxYbFphz/FxB0guV0/QeiEG+F4oVL/7OomXzVJzJqFItV6qRAzezuAWzQsWhM8kjW7tdzzb72n6B3xgf+WVWq3Z4AJZBpVuoS223bpyGn4
 IYVyfYIeLx2erS/GpAnfzRqVaF3VAWYBY3lT+N9dj/Uj1dhVCVSykX71oS5Kqz+anVH1xj3cpj/gri2YaNlpHV8j8EBYhYJakiz/CsywP08Tb6IAVBT6v7a6
 l6DE7xIj
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
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, hans.verkuil@cisco.com,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 02:53 AM, Quytelda Kahja wrote:
> Hans,
> 
> Thank you very much for your input on the patch; however this patch
> has already been applied to the staging tree.  Additionally:

I have no record of this being applied through linux-media. Did someone
else pick this up? Greg perhaps?

>> What coding style problem? You should give a short description of
>> what you are fixing.
> The subject of the patch (which becomes the subject of the email when
> using `git format-patch`) describes the change more fully: "Staging:
> bcm2048: Fix function argument alignment in radio-bcm2048.c".  It's a
> really trivial patch, so there's not too much to say.  That extra
> comment is just redundant, I suppose.

Usually you just show the warnings that gcc or sparse or whatever
produced.

> 
>> Just drop this change: it will replace one warning (non-aligned) with
>> another (> 80 cols).
> Breaking the 80 character line limit is arguably excusable for this
> code because of the 36 character function name and 30 character
> constant name; additionally, it has been said that the 80 character
> line limit will probably be increased in the future since we run
> modern machines that aren't limited to 80 character terminals anymore,
> so this warning may soon be irrelevant anyway.

I know people who would be very annoyed if the 80 char limit is lifted.

Anyway, in the end you look at whether a patch is worth it or not,
and this part isn't.

But if it is already applied by someone then this is all moot.

Regards,

	Hans

> 
> Thank you,
> Quytelda Kahja
> 
> On Mon, Feb 26, 2018 at 5:51 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>> On 02/20/2018 07:53 AM, Quytelda Kahja wrote:
>>> Fix a coding style problem.
>>
>> What coding style problem? You should give a short description of
>> what you are fixing.
>>
>>>
>>> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
>>> ---
>>> This is the patch without the unnecessary fixes for line length.
>>>
>>>  drivers/staging/media/bcm2048/radio-bcm2048.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
>>> index 06d1920150da..f38a4f2acdde 100644
>>> --- a/drivers/staging/media/bcm2048/radio-bcm2048.c
>>> +++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
>>> @@ -1864,7 +1864,7 @@ static int bcm2048_probe(struct bcm2048_device *bdev)
>>>               goto unlock;
>>>
>>>       err = bcm2048_set_fm_search_rssi_threshold(bdev,
>>> -                                     BCM2048_DEFAULT_RSSI_THRESHOLD);
>>> +                                                BCM2048_DEFAULT_RSSI_THRESHOLD);
>>>       if (err < 0)
>>>               goto unlock;
>>>
>>
>> Just drop this change: it will replace one warning (non-aligned) with
>> another (> 80 cols).
>>
>> This code is fine as it is.
>>
>> Regards,
>>
>>         Hans
>>
>>> @@ -1942,9 +1942,9 @@ static irqreturn_t bcm2048_handler(int irq, void *dev)
>>>   */
>>>  #define property_write(prop, type, mask, check)                              \
>>>  static ssize_t bcm2048_##prop##_write(struct device *dev,            \
>>> -                                     struct device_attribute *attr,  \
>>> -                                     const char *buf,                \
>>> -                                     size_t count)                   \
>>> +                                   struct device_attribute *attr,    \
>>> +                                   const char *buf,                  \
>>> +                                   size_t count)                     \
>>>  {                                                                    \
>>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>>       type value;                                                     \
>>> @@ -1966,8 +1966,8 @@ static ssize_t bcm2048_##prop##_write(struct device *dev,               \
>>>
>>>  #define property_read(prop, mask)                                    \
>>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>>> -                                     struct device_attribute *attr,  \
>>> -                                     char *buf)                      \
>>> +                                  struct device_attribute *attr,     \
>>> +                                  char *buf)                         \
>>>  {                                                                    \
>>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>>       int value;                                                      \
>>> @@ -1985,8 +1985,8 @@ static ssize_t bcm2048_##prop##_read(struct device *dev,                \
>>>
>>>  #define property_signed_read(prop, size, mask)                               \
>>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>>> -                                     struct device_attribute *attr,  \
>>> -                                     char *buf)                      \
>>> +                                  struct device_attribute *attr,     \
>>> +                                  char *buf)                         \
>>>  {                                                                    \
>>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>>       size value;                                                     \
>>> @@ -2005,8 +2005,8 @@ property_read(prop, mask)                                               \
>>>
>>>  #define property_str_read(prop, size)                                        \
>>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>>> -                                     struct device_attribute *attr,  \
>>> -                                     char *buf)                      \
>>> +                                  struct device_attribute *attr,     \
>>> +                                  char *buf)                         \
>>>  {                                                                    \
>>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>>       int count;                                                      \
>>> @@ -2175,7 +2175,7 @@ static int bcm2048_fops_release(struct file *file)
>>>  }
>>>
>>>  static __poll_t bcm2048_fops_poll(struct file *file,
>>> -                                   struct poll_table_struct *pts)
>>> +                               struct poll_table_struct *pts)
>>>  {
>>>       struct bcm2048_device *bdev = video_drvdata(file);
>>>       __poll_t retval = 0;
>>>
>>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
