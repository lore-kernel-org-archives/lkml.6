Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557122-1518188052-2-16652043448166128487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518188052; b=LCF4y7dEDXCzgywNI7zCrqo3V/i5rD6Yw5A157VdlqMxZOE
    F2TBqYIo/fLZYQqBAtBcSSEy0QR0SY5UOZKQN9JNpgqs/xs9aOZYqjB8sgMs/4OH
    WKmQHu/tmbQ+3kCDywelnd1CsQZpBCOcBoGTokBa+mKz1nCA7R1jTn/DurWZDFHR
    9Du8iIBInz3PPc5XZI/TVQ5NZxlHFbBLqTS5rH6QJxSvT+eQ2D94nyNClx/FS8z/
    or9yU5Q0vS4WXNyAE/z9CGeHKaLtal/UraPkNvIZTdi2lcku9A9FqPBmiOfAy/jh
    DF7Rj4BcUAMeqhWlkO6KHCP+dFC9pHy8xNu7w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518188052; bh=wHwCicWaMK0AVPRyJSCna/h05Xn+Uikmf0bIJWglGbM=; b=i
    E1Jz0H6RRd7MmMZiiGGQzNL60A5d/i80jLUuB2NtgzRyPTY23yltuTPK9wXe0io8
    nFnJW2fPftkeHjuvmlwCyMybrXczcccW7Ql3c1WKMvbgSn9TTQIZPyn5tMWdlzW4
    U1Pe9Ac9jpTPz4DSVh+JtenJ9ipq/h0dh9pcMyz0ebt9koU7rAw/lWb6pM6Pc3Y3
    q/KS1Mx+tsNc8QHVg7YSMqPIYCyPCEtQkbTJbLDbxWvLroVGbGHLwMQR2B8FV5wz
    a6dxMLbKspkM6W7rBphYCxeYEdTHpPX+keVMZBYKDjP9hl1S2KWd+EsdyGvSqTld
    uDRpd4rpYYY+YnercVX4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=C1eW76jH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=C1eW76jH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeBIOxv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:53:51 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:33842 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeBIOxu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 09:53:50 -0500
Subject: Re: [PATCH] v4l: vsp1: Fix continuous mode for dual pipelines
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "Stable v4.14+" <stable@vger.kernel.org>
References: <1518182305-17988-1-git-send-email-kbingham@kernel.org>
 <2830648.6d5UhGC3vQ@avalon>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <699aa554-3e95-704f-44ac-d4c024745d84@ideasonboard.com>
Date: Fri, 9 Feb 2018 14:53:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2830648.6d5UhGC3vQ@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laurent,

On 09/02/18 13:27, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Friday, 9 February 2018 15:18:25 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> To allow dual pipelines utilising two WPF entities when available, the
>> VSP was updated to support header-mode display list in continuous
>> pipelines.
>>
>> A small bug in the status check of the command register causes the
>> second pipeline to be directly afflicted by the running of the first;
>> appearing as a perceived performance issue with stuttering display.
>>
>> Fix the vsp1_dl_list_hw_update_pending() call to ensure that the read
>> comparison corresponds to the correct pipeline.
>>
>> Fixes: eaf4bfad6ad8 ("v4l: vsp1: Add support for header display
>> lists in continuous mode")
>> Cc: "Stable v4.14+" <stable@vger.kernel.org>
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Good catch !
> 
> The patch looks good to me, but I wonder if we shouldn't write the subject 
> line as "v4l: vsp1: Fix header display list status check in continuous mode". 

I'm fine with that,

Will resend with your RB tag.


> Sure, we're fixing continuous mode for dual pipelines, but that's more of a 
> side effect, it's header display lists that are broken as a whole in 
> continuous mode, even if we only use that for dual pipelines right now.
> 
> Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Please let me know if you'd like to rewrite the commit message.
> 
>> ---
>>  drivers/media/platform/vsp1/vsp1_dl.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/vsp1/vsp1_dl.c
>> b/drivers/media/platform/vsp1/vsp1_dl.c index 8cd03ee45f79..34b5ed2592f8
>> 100644
>> --- a/drivers/media/platform/vsp1/vsp1_dl.c
>> +++ b/drivers/media/platform/vsp1/vsp1_dl.c
>> @@ -509,7 +509,8 @@ static bool vsp1_dl_list_hw_update_pending(struct
>> vsp1_dl_manager *dlm) return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
>>  			  & VI6_DL_BODY_SIZE_UPD);
>>  	else
>> -		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
>> +		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
>> +			  & VI6_CMD_UPDHDR);
> 
> /me feels so ashamed.

Bah, it's only a brace out of place. I mean, what harm could it do ... hehe :-)

Personally I still blame the compiler for not picking up on the fact that we
told it to do something we didn't want it to do.

/me ducks to avoid all the items thrown by the compiler guys...

>>  }
>>
>>  static bool vsp1_dl_hw_active(struct vsp1_dl_manager *dlm)

--
Kieran
