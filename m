Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AG47ELulO5BsUJAi5zpBEzt+C0e7xNG3bmKZDAJOctiDSeRaqVfEA6rM8NIHHA3ftGk6JAYCuCDn
ARC-Seal: i=1; a=rsa-sha256; t=1522080957; cv=none;
        d=google.com; s=arc-20160816;
        b=HTe1IcYtTHz22EoIJXa2ogVzMnIysnGQoSjOgwuVsrQK9ZapWPsNDJoRU9XfyV+BJ4
         jF601oq4ui5GaF+0thEUFaBrL+0wdeLvpKVSIXsHLokQW2Qufqw68qrNzvGxqanacKaq
         ezsvEXUt7bDsTpChwdL9igOgcRDYIzwt+zueMkrZspzGj0hxY6a94YcuiPVN81+3RPb4
         ldTmiLOfdH1whu4c8a+qsSdLpdjepsi1ZTYgxtM93Im7UBeqURid2n+0fO0F3MZFAlF/
         AbHNsFHb5/GiETy40x19HZ4l7IPkJAS6ndGwTD6TWjzZvo1d6gu42ebegH0u3GCACN6n
         JwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:arc-authentication-results;
        bh=cNfNV8j+J9MlMHmS9+QAG3sAcPTN9RtQBMuagBJEh0A=;
        b=lOkaGMqjj9a6fQ0KYvgfwDVPytOuzy+d0yevQcLDpK4fNITWHu26i6XsBAzYBIQ4kw
         wGZWOxUugREolRNJEZ7NdTXzUtohh+jOBc23g0l1fOkugwFyNkm1DuzcXDJxEF3VXWzt
         DuGe8PgyFl7xpQwtrxyiwDNkMmAfcuss+ZwKbK1wA7mQWnQC3jOA+nQBmtujnRFanhgW
         5gU/fB43icWuBr3ZulrdQYnLC5A8HqE3EdP1dXJJAksCk+tiXwUx6JWnAipspqpnFHYy
         gBVj/BMzvTUf0Gy6L9f1Esr1KfzseRY1UfxwS/ChkHklh9wXwur2hcJULrhexvAoD9EJ
         XRxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Subject: Re: [PATCH] staging: wilc1000: check for kmalloc allocation failures
To: Ajay Singh <ajay.kathat@microchip.com>
Cc: Joe Perches <joe@perches.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180321191941.4126-1-colin.king@canonical.com>
 <1521662598.7999.33.camel@perches.com>
 <20180326210548.791f070a@ajaysk-VirtualBox>
From: Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; keydata=
 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
Message-ID: <ebe99f8e-5e55-c5cd-59d5-ec618164604a@canonical.com>
Date: Mon, 26 Mar 2018 17:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326210548.791f070a@ajaysk-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595576138463353935?=
X-GMAIL-MSGID: =?utf-8?q?1596017561920067285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/03/18 16:35, Ajay Singh wrote:
> Thanks for submitting the patch.
> 
> On Wed, 21 Mar 2018 13:03:18 -0700
> Joe Perches <joe@perches.com> wrote:
> 
>> On Wed, 2018-03-21 at 19:19 +0000, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> There are three kmalloc allocations that are not null checked which
>>> potentially could lead to null pointer dereference issues. Fix this
>>> by adding null pointer return checks.
>>
>> looks like all of these should be kmemdup or kstrdup
>>
>>>  
>>> @@ -951,6 +955,10 @@ static s32 handle_connect(struct wilc_vif *vif,
>>>  	if (conn_attr->ssid) {
>>>  		hif_drv->usr_conn_req.ssid = kmalloc(conn_attr->ssid_len + 1,
>>>  						     GFP_KERNEL);
>>> +		if (!hif_drv->usr_conn_req.ssid) {
>>> +			result = -ENOMEM;
>>> +			goto error;
>>> +		}
>>>  		memcpy(hif_drv->usr_conn_req.ssid,
>>>  		       conn_attr->ssid,
>>>  		       conn_attr->ssid_len);
> 
> With this changes the Coverity reported warning is handled correctly.
> 
> For further improvement to the patch, as Joe Perches suggested, its better
> to make use of kmemdup instead of kmalloc & memcpy. As kstrdup requires the
> source string to be NULL terminated('\0') and conn_attr->ssid might not  
> contains the '\0' terminated string. So kmemdup with length of 
> 'conn_attr->ssid_len' can be used instead.
> 
> Please include the changes by using kmemdup() for all kmalloc/memcpy in
> this patch.

The original has been included into Greg's staging repo, so I'll send a
send patch that addresses the kmemdup.

Colin
> 
> 
> 
> Regards,
> Ajay
> 
