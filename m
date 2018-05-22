Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEVQYv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:24:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbeEVQYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:24:46 -0400
Subject: Re: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
To: Jens Axboe <axboe@kernel.dk>, adam.manzanares@wdc.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org, hch@infradread.org,
        jmoyer@redhat.com
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
 <20180522150737.9893-3-adam.manzanares@wdc.com>
 <11fb2ee5-8352-2d35-3154-68637d99b096@kernel.dk>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=rgoldwyn@suse.de; prefer-encrypt=mutual; keydata=
 xsDiBEaI9tIRBAC+jCQxwxm9mPCrzNiUskTzyLKUPLdW4n8Rjmt/N4ISt0AZWDKq7SpiDQjr
 yfOORLFFBFsfSH40OJlBjIpO+mh9XHPbc83bOESJdT5huIbC/0yuqR0xYVt+U0FLXQJ3w70N
 9eALGVxPPcQ3uIBpdTJUqkvKf9x3xLUdqRe/GQnXcwCgjKJ0sON51KlW36oNEyj4gF50Pg8D
 /jis+JcqnVlunIkGljWiYu6gNVXBXXiFqqbxnwWDGrA1e86Xl8A/aJn5tP/XELURNU7L1H1L
 f1g3K/usDaTkNsJ1HwmH378ctJTu7JYx/euCoz7MhKEJ2EgLC0Ob262cnk9JLAnpJOYPwIhA
 dgdtcdqASfln8gfP+6M+qFqOopfKA/9xLmyVSfxEoy4qdhlUC3GRFjZ5Ste2aOr9G0JXnWIg
 jccn/dT4sOb2lhKIKHiJmD4ns8Io01QPh/Cd6ecZ6Cx3InCQHyzMOVvZn0fdbO9/+348yRSl
 YOBXoViPxlUWGc/52eWohuleDhsrtn0aVX4d1zvhc5oswj6dKDDvDnnN580lR29sZHd5biBS
 b2RyaWd1ZXMgPHJnb2xkd3luQHN1c2UuY29tPsKVBBMRAgBVAhsjBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAIZAQUJHC+BBRYhBO+WsixA7W+EivWnh0m5sHYwIjhsBQJamCrlEhhoa3A6
 Ly9wZ3AubWl0LmVkdQAKCRBJubB2MCI4bHt8AJwKjLlv73VEx6e63oQfUoOJKibHWwCfXIG1
 LHEVJbYPWAPKQ6Zk8ZCodXrOwU0ERoj26RAIAKKaKET9+fkkdP745IAQ17wrIzkpU/pAz90C
 fjJVhKngrb6PMFHyOPXlRAyJPCpp8Whl8P+KmAM7SZof4n8aLyrl+SVYFMe9RwYSshD7eNBD
 WmPNJd2qK8JJLUC8/ZRb5yw/bHfIRITogS9Tie5WJwHjMapizdQV8dyI+hSpYmWPDSOUaYCF
 T/nWaQP2NObZDFpBX3P8kP3LSTP+JW3Fz06CrJ03bAtm2CPDNI02sc5MHvRJXGNM2grvh+bK
 4V0sDrBeWr9sHy5ADoIx9PXGIfNH4NbSVBSGW3Oy8dmZnDfMgtAb9oY6HaGKZDj/F+AgxywB
 8oyvGfrJhfizIYROmycAAwUH/AtsttodDYydHeM9GFiZy0o/n4FAseYiMJKRI8fC2pYvrojt
 zbpQKXa64vQv2INtJHm8D1iGpzdrNkjL5jlqPKSUIkhwt9yUpOH3UQifwYOeKZUiv7vrapnW
 1gJb7RWhg4ske+qOa2FKvFVMsJ2quuu0qHOH0K8l7T8VqaW8FH4097c3TeSO17qRtwnNm+F7
 a+cXijMOaajZ9Xp4X04+wrEf7Rmvhc0zr96t3Z5QYx4ZwoyDfLefm5ORUe2CcRva7TnycB9P
 IxdGoVS2eIyepO+RMjvq5e6xjkpoiJ3cybQhsUt+pZd/KGSkZmhHpId3Y6zivOq7Lj+ELOtW
 dOTcV0TCTwQYEQIADwIbDAUCWVJ2GQUJHC+AsAAKCRBJubB2MCI4bC2IAJoDDDkaRi7G/lzz
 fUIV2179DCq38wCaAmivz68q3lkN6rF6vnh5DEGS74c=
Message-ID: <084d253c-52ab-7b23-521c-28602c56153b@suse.de>
Date: Tue, 22 May 2018 11:24:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <11fb2ee5-8352-2d35-3154-68637d99b096@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 10:32 AM, Jens Axboe wrote:
> On 5/22/18 9:07 AM, adam.manzanares@wdc.com wrote:
>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>
>> In order to avoid kiocb bloat for per command iopriority support, rw_hint
>> is converted from enum to a u16. Added a guard around ki_hint assignment.
>>
>> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  include/linux/fs.h | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 7f07977bdfd7..50de40dbbb85 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -284,6 +284,8 @@ enum rw_hint {
>>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>>  };
>>  
>> +#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
> 
> Instead of having to do this and now rely on those now being synced,
> how about something like the below.
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..070438d0b62d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -299,7 +299,7 @@ struct kiocb {
>  	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
>  	void			*private;
>  	int			ki_flags;
> -	enum rw_hint		ki_hint;
> +	u16			ki_hint;
>  } __randomize_layout;
>  
>  static inline bool is_sync_kiocb(struct kiocb *kiocb)
> @@ -1927,12 +1927,22 @@ static inline enum rw_hint file_write_hint(struct file *file)
>  
>  static inline int iocb_flags(struct file *file);
>  
> +static inline u16 ki_hint_validate(enum rw_hint hint)
> +{
> +	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;

This looks complex to me. Would force a reader to lookback at what
datatype ki_hint is. I'd prefer to declare it as u16 max_hint = -1, or
even the previous #define MAX_KI_HINT format is easier to read. Just a
program reading style you are comfortable with though.


-- 
Goldwyn
