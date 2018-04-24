Return-Path: <kieran.bingham+renesas@ideasonboard.com>
X-Google-Smtp-Source: AB8JxZqNDoMKa24eStKGpXnLl89XpCFX3H2FqhWRz/89CUH8DIkonAQ49MDzhO20K7WYnuVp8zdK
ARC-Seal: i=1; a=rsa-sha256; t=1524567318; cv=none;
        d=google.com; s=arc-20160816;
        b=VYcvWAMsnCCZCNg9YmC+raNcu7j3tPr8JHNxox0uK2ZxbVKHhKBtRR1r5/5dxzCXsW
         sAwbqkjApUeXaasGDJTOwRjByJMzCw/50T4v24PaaewhX9imfJNKMqy6D061SujSphLh
         Qt8i0PqkhBXNg17iaKIK4hhhTG9PlCgxAycYAF3nCM+3W2UqV8P5s7UYBKMyPL+82YuE
         hyN9WnI9lA8wjncxSelKwHi3bC52NP/qqHuXglZ9w6eljTUgi9xOFsERhfNt2wwc53gE
         H2xXMcBVbdWLjxwLsVBbEU/02dpNPJ6MzboK5AQ9oB2YwW9VHvxYVgLsfyQYjNVmXrCs
         kMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:autocrypt:openpgp:from
         :reply-to:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=iJT1bhdmGPU64/0i5nYCbbApqPYNTfBn4vjLTa6gLh8=;
        b=FbB8IWASvoLwi1BQzAsATRfDAuQMbBe+BO5YTo9h7C9klxATk+ZDaB/aJblAITgzk3
         n2vbFYagzgMuy5eOjHN+bhU0y8h0e9meeiW9l/6YWRL/bvUovEb9mY/SJaUgPku/Jzzh
         jcbmG/AFAQcV0wkIzmexTrGWci0YplEgiA0XBwsGy6+5OfqC8xDFY3isGCQbjeovEEKH
         rgB9UIMrZUruaWj43fStw8/oclOEY10yXXh4HtwaGpR40LqcRsBZLU+bwfyIOuI1HnEM
         tMwLCrzOSk5Kgd6GRAw0BTo5QhSToIq7S32UiYzlZCSQjdtlgiMVOfrsjK0OopR4ZhDe
         eJtw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=sFatY7w7;
       spf=pass (google.com: domain of kieran.bingham+renesas@ideasonboard.com designates 2001:4b98:dc2:55:216:3eff:fef7:d647 as permitted sender) smtp.mailfrom=kieran.bingham+renesas@ideasonboard.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=sFatY7w7;
       spf=pass (google.com: domain of kieran.bingham+renesas@ideasonboard.com designates 2001:4b98:dc2:55:216:3eff:fef7:d647 as permitted sender) smtp.mailfrom=kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] staging: media: use relevant lock
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <1501763212-1394-1-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: kieran.bingham@ideasonboard.com
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham+renesas@ideasonboard.com;
 prefer-encrypt=mutual; keydata=
 xsFNBFYE/WYBEACs1PwjMD9rgCu1hlIiUA1AXR4rv2v+BCLUq//vrX5S5bjzxKAryRf0uHat
 V/zwz6hiDrZuHUACDB7X8OaQcwhLaVlq6byfoBr25+hbZG7G3+5EUl9cQ7dQEdvNj6V6y/SC
 rRanWfelwQThCHckbobWiQJfK9n7rYNcPMq9B8e9F020LFH7Kj6YmO95ewJGgLm+idg1Kb3C
 potzWkXc1xmPzcQ1fvQMOfMwdS+4SNw4rY9f07Xb2K99rjMwZVDgESKIzhsDB5GY465sCsiQ
 cSAZRxqE49RTBq2+EQsbrQpIc8XiffAB8qexh5/QPzCmR4kJgCGeHIXBtgRj+nIkCJPZvZtf
 Kr2EAbc6tgg6DkAEHJb+1okosV09+0+TXywYvtEop/WUOWQ+zo+Y/OBd+8Ptgt1pDRyOBzL8
 RXa8ZqRf0Mwg75D+dKntZeJHzPRJyrlfQokngAAs4PaFt6UfS+ypMAF37T6CeDArQC41V3ko
 lPn1yMsVD0p+6i3DPvA/GPIksDC4owjnzVX9kM8Zc5Cx+XoAN0w5Eqo4t6qEVbuettxx55gq
 8K8FieAjgjMSxngo/HST8TpFeqI5nVeq0/lqtBRQKumuIqDg+Bkr4L1V/PSB6XgQcOdhtd36
 Oe9X9dXB8YSNt7VjOcO7BTmFn/Z8r92mSAfHXpb07YJWJosQOQARAQABzTBLaWVyYW4gQmlu
 Z2hhbSA8a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT7CwYAEEwEKACoCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4ACGQEFAlnDk/gFCQeA/YsACgkQoR5GchCkYf3X5w/9EaZ7
 cnUcT6dxjxrcmmMnfFPoQA1iQXr/MXQJBjFWfxRUWYzjvUJb2D/FpA8FY7y+vksoJP7pWDL7
 QTbksdwzagUEk7CU45iLWL/CZ/knYhj1I/+5LSLFmvZ/5Gf5xn2ZCsmg7C0MdW/GbJ8IjWA8
 /LKJSEYH8tefoiG6+9xSNp1p0Gesu3vhje/GdGX4wDsfAxx1rIYDYVoX4bDM+uBUQh7sQox/
 R1bS0AaVJzPNcjeC14MS226mQRUaUPc9250aj44WmDfcg44/kMsoLFEmQo2II9aOlxUDJ+x1
 xohGbh9mgBoVawMO3RMBihcEjo/8ytW6v7xSF+xP4Oc+HOn7qebAkxhSWcRxQVaQYw3S9iZz
 2iA09AXAkbvPKuMSXi4uau5daXStfBnmOfalG0j+9Y6hOFjz5j0XzaoF6Pln0jisDtWltYhP
 X9LjFVhhLkTzPZB/xOeWGmsG4gv2V2ExbU3uAmb7t1VSD9+IO3Km4FtnYOKBWlxwEd8qOFpS
 jEqMXURKOiJvnw3OXe9MqG19XdeENA1KyhK5rqjpwdvPGfSn2V+SlsdJA0DFsobUScD9qXQw
 OvhapHe3XboK2+Rd7L+g/9Ud7ZKLQHAsMBXOVJbufA1AT+IaOt0ugMcFkAR5UbBg5+dZUYJj
 1QbPQcGmM3wfvuaWV5+SlJ+WeKIb8tbOwU0EVgT9ZgEQAM4o5G/kmruIQJ3K9SYzmPishRHV
 DcUcvoakyXSX2mIoccmo9BHtD9MxIt+QmxOpYFNFM7YofX4lG0ld8H7FqoNVLd/+a0yru5Cx
 adeZBe3qr1eLns10Q90LuMo7/6zJhCW2w+HE7xgmCHejAwuNe3+7yt4QmwlSGUqdxl8cgtS1
 PlEK93xXDsgsJj/bw1EfSVdAUqhx8UQ3aVFxNug5OpoX9FdWJLKROUrfNeBE16RLrNrq2ROc
 iSFETpVjyC/oZtzRFnwD9Or7EFMi76/xrWzk+/b15RJ9WrpXGMrttHUUcYZEOoiC2lEXMSAF
 SSSj4vHbKDJ0vKQdEFtdgB1roqzxdIOg4rlHz5qwOTynueiBpaZI3PHDudZSMR5Fk6QjFooE
 XTw3sSl/km/lvUFiv9CYyHOLdygWohvDuMkV/Jpdkfq8XwFSjOle+vT/4VqERnYFDIGBxaRx
 koBLfNDiiuR3lD8tnJ4A1F88K6ojOUs+jndKsOaQpDZV6iNFv8IaNIklTPvPkZsmNDhJMRHH
 Iu60S7BpzNeQeT4yyY4dX9lC2JL/LOEpw8DGf5BNOP1KgjCvyp1/KcFxDAo89IeqljaRsCdP
 7WCIECWYem6pLwaw6IAL7oX+tEqIMPph/G/jwZcdS6Hkyt/esHPuHNwX4guqTbVEuRqbDzDI
 2DJO5FbxABEBAAHCwWUEGAEKAA8CGwwFAlnDlGsFCQeA/gIACgkQoR5GchCkYf1yYRAAq+Yo
 nbf9DGdK1kTAm2RTFg+w9oOp2Xjqfhds2PAhFFvrHQg1XfQR/UF/SjeUmaOmLSczM0s6XMeO
 VcE77UFtJ/+hLo4PRFKm5X1Pcar6g5m4xGqa+Xfzi9tRkwC29KMCoQOag1BhHChgqYaUH3yo
 UzaPwT/fY75iVI+yD0ih/e6j8qYvP8pvGwMQfrmN9YB0zB39YzCSdaUaNrWGD3iCBxg6lwSO
 LKeRhxxfiXCIYEf3vwOsP3YMx2JkD5doseXmWBGW1U0T/oJF+DVfKB6mv5UfsTzpVhJRgee7
 4jkjqFq4qsUGxcvF2xtRkfHFpZDbRgRlVmiWkqDkT4qMA+4q1y/dWwshSKi/uwVZNycuLsz+
 +OD8xPNCsMTqeUkAKfbD8xW4LCay3r/dD2ckoxRxtMD9eOAyu5wYzo/ydIPTh1QEj9SYyvp8
 O0g6CpxEwyHUQtF5oh15O018z3ZLztFJKR3RD42VKVsrnNDKnoY0f4U0z7eJv2NeF8xHMuiU
 RCIzqxX1GVYaNkKTnb/Qja8hnYnkUzY1Lc+OtwiGmXTwYsPZjjAaDX35J/RSKAoy5wGo/YFA
 JxB1gWThL4kOTbsqqXj9GLcyOImkW0lJGGR3o/fV91Zh63S5TKnf2YGGGzxki+ADdxVQAm+Q
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <b8a26008-f8d5-43d6-b93d-0f3d20074ac0@ideasonboard.com>
Date: Tue, 24 Apr 2018 11:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1501763212-1394-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1574714464195858726?=
X-GMAIL-MSGID: =?utf-8?q?1598624700668654527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Julia

Thank you for the patch.

On 03/08/17 13:26, Julia Lawall wrote:
> The data protected is video_out2 and the lock that is released is
> &video_out2->dma_queue_lock, so it seems that that lock should be
> taken as well.

I agree - this certainly looks like there was a copy/paste error perhaps and is
locking the wrong video.

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>




> ---
>  drivers/staging/media/davinci_vpfe/dm365_resizer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/davinci_vpfe/dm365_resizer.c b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
> index 857b0e8..4910cb7 100644
> --- a/drivers/staging/media/davinci_vpfe/dm365_resizer.c
> +++ b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
> @@ -1059,7 +1059,7 @@ static void resizer_ss_isr(struct vpfe_resizer_device *resizer)
>  	/* If resizer B is enabled */
>  	if (pipe->output_num > 1 && resizer->resizer_b.output ==
>  	    RESIZER_OUTPUT_MEMORY) {
> -		spin_lock(&video_out->dma_queue_lock);
> +		spin_lock(&video_out2->dma_queue_lock);
>  		vpfe_video_process_buffer_complete(video_out2);
>  		video_out2->state = VPFE_VIDEO_BUFFER_NOT_QUEUED;
>  		vpfe_video_schedule_next_buffer(video_out2);
> 
