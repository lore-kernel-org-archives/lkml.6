Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-89514-1519696434-2-18179810298431853082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519696433; b=WLQFT5scbGaOE2Poa8/o8dAMmwMmnURvw6y0dbLw5EF9Z/i
    tSE+TDceEf2TIG9IuKQx31vYCowbfo0nWs3+O3icB1PzzLAXmCaUGkoUNB8A1I7F
    7qVHFtDoenTUEx+b43qZUU2brquumTe2wUJVhFDniwqLXdryZO6gAaDAyjBMc+Tr
    yMIKCLTxb/PJTnAUJt/Gqu6TNBROfbPrPaEnIJY29+l5mHiVnDLv1t/veq6YO16N
    FsjquLJr+bx0wT+quV+hJU2rldKW2aSO8CQVsZrVaxVD5iJAm8HRrvrUcImmIsG9
    xRITBAafbQUJOMgpHXFemKbslZYsUBhqnFItJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519696433; bh=V
    dRRswXYEz2wtWkbkKT8QCv2VAIyW/FhJ8jqKhm/lbI=; b=BCZUiwwH5bFtM9HuL
    iVPsSQAojTHLNpWiWqvCzd1Zz5UnZJcmIxwkw1To1vMxQ+hGk8wKkQbvohjXsbu/
    lAXCkQoi2KjWXEsEWWTOIuKQ38k6lo5AM5vudH+Do4Mx+K9dYefhBCoYNNNisgj4
    pTVR9nRbzfaDplC/I8a0geaN+UEPKWSvJoZy879ecQP+hP/9Xd8MPMVmVGWBGS6D
    nA4FZaupGF2JFXBDJXsf3taAY/LvyvQG04GYIWM168wD7zw1qVDTw1iiXA+dUDtG
    oKsYIM4u7e8sAu/1rs2sw80JVmJnIrF6ybQ0yDPg7sBxL1ji9YtqlVYRH7BLfNmm
    pDMnw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227kVmfcm6PCki6Aa4NBdA+YEJIzcnWfZ5fH88lr0wdplXkZcFv61kfvrrLb5/wbGlt60sj5fHosJdsjTpfwY9k=
MIME-Version: 1.0
In-Reply-To: <cb62e915-eb9c-9252-1f0a-cc85c8ea3530@xs4all.nl>
References: <20180219072550.hz4vpomsaz2ajrnm@mwanda>
 <20180220065304.8943-1-quytelda@tamalin.org>
 <cb62e915-eb9c-9252-1f0a-cc85c8ea3530@xs4all.nl>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Mon, 26 Feb 2018 17:53:44 -0800
X-Gmail-Original-Message-ID: <CAFLvi2357U3HAt3mXDdNdZs4QA9mqWntTny4XyvtSfV2hu1dmA@mail.gmail.com>
Message-ID: <CAFLvi2357U3HAt3mXDdNdZs4QA9mqWntTny4XyvtSfV2hu1dmA@mail.gmail.com>
Subject: Re: [PATCH v2] Staging: bcm2048: Fix function argument alignment in
 radio-bcm2048.c.
To: Hans Verkuil <hverkuil@xs4all.nl>
X-Provags-ID: V03:K0:ktcTA51nsgLkv4uZSMVt8Ye1pXL7dDjqgvZU+HolVYZAKT2ygOa
 At8ce7peWBTrFJQaXSUWyC39MxJrCxynH877RI0DV0R9FQBhWWm9YWYjBVElqUQfsGYUvoq
 9G65x6zJfcpdz8/ffWMGU/z2y5wOK0Xionbh83tplW+7NVoBrFZiPBWXPa65hFt5Dtpp6PP
 aZCHgXlDA6+FZ2wO0JCGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D/HvR/EwIjs=:33UioOb+6QOjtpr476WEpH
 TDBSBC/rZFG3Z5g4RYZWr8A90WMOgrDG9lNYISQEq8860I+/Czp034gMt5gdWtIlSsAhpk86u
 VAJ7AK0PhtiBtViF8CHQ8RSyOqkFQjNkYK5AScBrivkT09/Jx35+gELnl3RMHGdg9AJAfu1qW
 q+TUfu6ORtz7AZWgQ2K2IpnGFMreN5qb1ESMc8Kt2bFBcI8RHJtoTkC659zpbqxvmOj9lmofo
 QFdBDjDmBBVH2q+y9P6vyYizgWeM/lFrWSs955s22vqVllFaBVqKt41PowQoeSPrvv/H2Dpt4
 vtiXCfVXvJA9NV6RyWM6V54t9VJigq3eEVBTD28lYjFUG/PPxkVi1RYtGojW0AnOESHSVqegv
 4l47kWHtAFCgO8LrO2wNvM4nXwmLQ3Gwy+G4xCMx/N5w1boqm2wCcPUpqkXLNgnNpML0oO0Tz
 Mn+GdUUI3rIcteYakOh8pWp2CaA51o7rYsKUeMX76j/lHQr1wXTta692tv1WFC5O8IhCol/NX
 QDkkSaui+UQmbX1T/hPu8PJBWSo8fAucDM5yT/LKmP78O4Ur6eyMDpXc/bNAVMJU2avbHQVRn
 NWmMOgrO+u+bcVYLx2naqapsSlsN4JuFI8tDBaSgjUOL4ZDNCAUsAAxqQYOqstg1/AJ+tAekR
 7MNUohGmPaGhd/9gCjH2nKZDRvRmBMnCHsud/+ymxEcM6WV50FexIcDjaz0o6WRDhxcwhWKJn
 yyRQJ8MT+Dt3OhK7Dyv9MpTr8QEg/fnlfLL6+J3kDbCKGCR9bTr1xgPBPMU=
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

Hans,

Thank you very much for your input on the patch; however this patch
has already been applied to the staging tree.  Additionally:

> What coding style problem? You should give a short description of
> what you are fixing.
The subject of the patch (which becomes the subject of the email when
using `git format-patch`) describes the change more fully: "Staging:
bcm2048: Fix function argument alignment in radio-bcm2048.c".  It's a
really trivial patch, so there's not too much to say.  That extra
comment is just redundant, I suppose.

> Just drop this change: it will replace one warning (non-aligned) with
> another (> 80 cols).
Breaking the 80 character line limit is arguably excusable for this
code because of the 36 character function name and 30 character
constant name; additionally, it has been said that the 80 character
line limit will probably be increased in the future since we run
modern machines that aren't limited to 80 character terminals anymore,
so this warning may soon be irrelevant anyway.

Thank you,
Quytelda Kahja

On Mon, Feb 26, 2018 at 5:51 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 02/20/2018 07:53 AM, Quytelda Kahja wrote:
>> Fix a coding style problem.
>
> What coding style problem? You should give a short description of
> what you are fixing.
>
>>
>> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
>> ---
>> This is the patch without the unnecessary fixes for line length.
>>
>>  drivers/staging/media/bcm2048/radio-bcm2048.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
>> index 06d1920150da..f38a4f2acdde 100644
>> --- a/drivers/staging/media/bcm2048/radio-bcm2048.c
>> +++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
>> @@ -1864,7 +1864,7 @@ static int bcm2048_probe(struct bcm2048_device *bdev)
>>               goto unlock;
>>
>>       err = bcm2048_set_fm_search_rssi_threshold(bdev,
>> -                                     BCM2048_DEFAULT_RSSI_THRESHOLD);
>> +                                                BCM2048_DEFAULT_RSSI_THRESHOLD);
>>       if (err < 0)
>>               goto unlock;
>>
>
> Just drop this change: it will replace one warning (non-aligned) with
> another (> 80 cols).
>
> This code is fine as it is.
>
> Regards,
>
>         Hans
>
>> @@ -1942,9 +1942,9 @@ static irqreturn_t bcm2048_handler(int irq, void *dev)
>>   */
>>  #define property_write(prop, type, mask, check)                              \
>>  static ssize_t bcm2048_##prop##_write(struct device *dev,            \
>> -                                     struct device_attribute *attr,  \
>> -                                     const char *buf,                \
>> -                                     size_t count)                   \
>> +                                   struct device_attribute *attr,    \
>> +                                   const char *buf,                  \
>> +                                   size_t count)                     \
>>  {                                                                    \
>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>       type value;                                                     \
>> @@ -1966,8 +1966,8 @@ static ssize_t bcm2048_##prop##_write(struct device *dev,               \
>>
>>  #define property_read(prop, mask)                                    \
>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>> -                                     struct device_attribute *attr,  \
>> -                                     char *buf)                      \
>> +                                  struct device_attribute *attr,     \
>> +                                  char *buf)                         \
>>  {                                                                    \
>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>       int value;                                                      \
>> @@ -1985,8 +1985,8 @@ static ssize_t bcm2048_##prop##_read(struct device *dev,                \
>>
>>  #define property_signed_read(prop, size, mask)                               \
>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>> -                                     struct device_attribute *attr,  \
>> -                                     char *buf)                      \
>> +                                  struct device_attribute *attr,     \
>> +                                  char *buf)                         \
>>  {                                                                    \
>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>       size value;                                                     \
>> @@ -2005,8 +2005,8 @@ property_read(prop, mask)                                               \
>>
>>  #define property_str_read(prop, size)                                        \
>>  static ssize_t bcm2048_##prop##_read(struct device *dev,             \
>> -                                     struct device_attribute *attr,  \
>> -                                     char *buf)                      \
>> +                                  struct device_attribute *attr,     \
>> +                                  char *buf)                         \
>>  {                                                                    \
>>       struct bcm2048_device *bdev = dev_get_drvdata(dev);             \
>>       int count;                                                      \
>> @@ -2175,7 +2175,7 @@ static int bcm2048_fops_release(struct file *file)
>>  }
>>
>>  static __poll_t bcm2048_fops_poll(struct file *file,
>> -                                   struct poll_table_struct *pts)
>> +                               struct poll_table_struct *pts)
>>  {
>>       struct bcm2048_device *bdev = video_drvdata(file);
>>       __poll_t retval = 0;
>>
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
