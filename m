Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFEMhC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:37:02 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39903 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeFEMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:36:59 -0400
X-Google-Smtp-Source: ADUXVKJIIhaaB6fgm+rJ0wHygNAyd215pI8nsW+V1HhjOaU+a3fuBF23ymFBxntI59K5oirBnxqkwg==
Subject: Re: [greybus-dev] [PATCH] Staging:greybus Fix comparison to NULL
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Johan Hovold <johan@hovoldconsulting.com>
Cc: devel@driverdev.osuosl.org, Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
 <20180605053236.u57riboa47so66rr@vireshk-i7>
 <20180605090051.fngwzwpzr37ynatf@mwanda>
From: Alex Elder <elder@linaro.org>
Message-ID: <bbc826bc-2c86-3ff4-ad96-a4f0c33f9e88@linaro.org>
Date: Tue, 5 Jun 2018 07:36:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605090051.fngwzwpzr37ynatf@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 04:00 AM, Dan Carpenter wrote:
> On Tue, Jun 05, 2018 at 11:02:36AM +0530, Viresh Kumar wrote:
>> On 03-06-18, 08:52, Janani Sankara Babu wrote:
>>> This patch replaces comparison of var to NULL with !var
>>>
>>> Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>

Wow, such deep discussion for such a trivial patch!

I say we take it, mostly because I personally prefer being
permissive if there's nothing technically wrong with a patch,
but also because I'm swayed by the other comments.

That being said, I agree with Johan--the patch would be
improved with a little better comment about what motivated
the submission.  So I'll wait for v2.

					-Alex

>>> ---
>>>  drivers/staging/greybus/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/greybus/core.c b/drivers/staging/greybus/core.c
>>> index dafa430..5d14a4e 100644
>>> --- a/drivers/staging/greybus/core.c
>>> +++ b/drivers/staging/greybus/core.c
>>> @@ -48,7 +48,7 @@ static bool greybus_match_one_id(struct gb_bundle *bundle,
>>>  static const struct greybus_bundle_id *
>>>  greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
>>>  {
>>> -	if (id == NULL)
>>> +	if (!id)
>>
>> It is pretty much personal preference and there is no good reason to accept this
>> patch really.
> 
> Checkpatch complains, so it's Official Kernel Style now.
> 
> The != NULL comparison is a double negative which makes it not less
> annoying than official kernel style.
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 
