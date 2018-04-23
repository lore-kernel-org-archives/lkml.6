Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx4+Y5MoW4PRyNrDfl3UytLk2mQ1IoiQLmE7FJWReBx7tDe7vRCIYQmD4BS0K0Gs9Ik5EEsRl
ARC-Seal: i=1; a=rsa-sha256; t=1524497004; cv=none;
        d=google.com; s=arc-20160816;
        b=pdGZVb/nIJRg8OsK3j0Phk3+3SLTY8IdHMAh7XYfFKFvHWKrv54Iof2HWOMbO8W1TX
         HK6D5rg8qjqFiHLvPOhNIAunx97JbJlgyT/lbUlJj237z4kZ4yc+5lfQRWZOx3oXRDy+
         T+jTG8+4ReDQJlN8b3dCTKiyQhVEc3S9QeqZUU/W5HCyZyTCC4bNO53dMgkHqXeYs2kZ
         G7WxWwRodalC7Pb9zdqGmGUlEev+mFmC/Ib3CEycJteIDXnx669XDodoLsute0yWxeCm
         G5mNwZyKpKNJprTZImqYVv8JEiC/8uCpgyGtwsyGrAvKVFfEmrXd9L+Qi2nrxDk5/BC8
         Bg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=QwMlVQXjYdm3wJ810PbnPOnUxYWYGFEh/05aa28onLM=;
        b=zMurlj+uu2JDWTckwYo64FcCrClnRBbbEd1c4I/jq+X34AnPHjouWfDN40FX4Xf0j4
         wDTtGnOb1d5NL62d0K16aoyP17G3TxdVjc2/ynKmzGezhhl1BFad8vPbX+P4ugPXvMRu
         WhumYe0fH/kz3WNyN9ozKAD5ps8EUm041U2QTol+JmliragKIQpavlG/YoAuGgn48InD
         S9fcLJOP54Y++Qis7Dh+9zxYIg+JCgZ+vZRLrjgPjbxrlqD6IMeyx9PKOcEmLlPDXWok
         ioQIOx6NwOLCYXWtb8SpqXRFIY4Izi3n7n2LeS/h6E8jGuDBFTEX1MkzhY/kZr+ar961
         I+1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=rRhMdNx9;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=rRhMdNx9;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH] rpmsg: Correct support for MODULE_DEVICE_TABLE()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>
References: <20180421235529.17243-1-afd@ti.com>
 <20180422064758.GB16763@kroah.com>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <d677c7ae-87e2-1633-163f-72dd0c8faa4e@ti.com>
Date: Mon, 23 Apr 2018 10:23:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422064758.GB16763@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598401995374666421?=
X-GMAIL-MSGID: =?utf-8?q?1598550970896893142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/22/2018 01:47 AM, Greg Kroah-Hartman wrote:
> On Sat, Apr 21, 2018 at 06:55:29PM -0500, Andrew F. Davis wrote:
>> Due to missing a missing entry in file2alias.c MODULE_DEVICE_TABLE() are
>> not generating the proper module aliases. Add the needed entry here.
>>
>> Reported-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  scripts/mod/devicetable-offsets.c |  3 +++
>>  scripts/mod/file2alias.c          | 11 +++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
>> index 9fad6afe4c41..6667f7b491d6 100644
>> --- a/scripts/mod/devicetable-offsets.c
>> +++ b/scripts/mod/devicetable-offsets.c
>> @@ -139,6 +139,9 @@ int main(void)
>>  	DEVID(hv_vmbus_device_id);
>>  	DEVID_FIELD(hv_vmbus_device_id, guid);
>>  
>> +	DEVID(rpmsg_device_id);
>> +	DEVID_FIELD(rpmsg_device_id, name);
>> +
>>  	DEVID(i2c_device_id);
>>  	DEVID_FIELD(i2c_device_id, name);
>>  
> 
> I don't understand, what caused this to break?  Has this ever worked?
> 


I'm not sure if this ever worked.


>> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
>> index b9beeaa4695b..52fd54a8fe39 100644
>> --- a/scripts/mod/file2alias.c
>> +++ b/scripts/mod/file2alias.c
>> @@ -944,6 +944,17 @@ static int do_vmbus_entry(const char *filename, void *symval,
>>  }
>>  ADD_TO_DEVTABLE("vmbus", hv_vmbus_device_id, do_vmbus_entry);
>>  
>> +/* Looks like: rpmsg:S */
>> +static int do_rpmsg_entry(const char *filename, void *symval,
>> +			  char *alias)
>> +{
>> +	DEF_FIELD_ADDR(symval, rpmsg_device_id, name);
>> +	sprintf(alias, RPMSG_DEVICE_MODALIAS_FMT, *name);
>> +
>> +	return 1;
>> +}
>> +ADD_TO_DEVTABLE("rpmsg", rpmsg_device_id, do_rpmsg_entry);
> 
> Is this just for this one specific bus type?  How far back does this
> patch need to go?  How has no one noticed this before?
> 


Looks like the first half was added back at the beginning of this bus, so:

Fixes bcabbccabffe ("rpmsg: add virtio-based remote processor messaging
bus")

As for how this was not noticed before, the optimist in me wants to
assume everyone has just been not making these drivers as modules, the
pessimist wants to question how much this use this bus sees right now..

Thanks,
Andrew


> thanks,
> 
> greg k-h
> 
