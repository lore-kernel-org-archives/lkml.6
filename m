Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3191935-1517475453-2-11761924469256203289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517475453; b=J+d/TB14Pgo7NdOczDe4B7GTkKBqAKX5eqIRRa5EnRHgghe
    FGveokhECmpoaIS1Kyg2UVMdyLjruMW8xMIC9tbC08rAcRORahRtkPHE/BYCPoQD
    9Q8OOkdQkD+Tsq0piBPshMymYS9TJ2BSmlr4Sa6e1YAj0Q6Iz6EEko2/tUj5LPAu
    hTLJk4nkvlowe1CmkzgX+oV0KN+BlHy1j91adGJHtnsUzqT1EqSlwdclsne+Q0V/
    Tj5kXyT0IFmF5ivTucpcXY+/qHRUE4Orxs4T+XpatTu1eOYzGuDG2o7rS2ObALHv
    6bWny9blE0DM4HuboaSoi7ls0kgVWmyi8Hr6a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517475453; bh=1dbnKkEyW1CUWQWF4M//uXZ+OTMkicwnGtaBCtsyEVA=; b=g
    f7o9LdSpFb0YvjM8X+AIZw2nGy8vLemJ2jKaPEdhohDu2ioo7r4t051ybaq8pXl5
    ZC0KLfQESohwA9ZxpcGME0wuzEyLBLTQWk6tw8VcoupRSygcGhzo2hsh5l2WcYiw
    7Gpu+dLnbux6iVOY9BgTkOUgGNCoK4zDd71KlhLg/myWL333Ps511gmqiNs82MbW
    v/DUuuIYw/TMmHNshqjVk6PVefJskB5zJ4wFCk6vNSD3LKx16ZU4nTkD/mIcHNQC
    I4RyRusx31S9a+3ycAhPeXmSTBLU1Jc3CNAXzmeEFsjW4fmtf+kvRku0AYNyit2F
    aMfslcgLgS42RKitVb68A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gsl/YMRj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gsl/YMRj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeBAI53 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 03:57:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39105 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeBAI5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 03:57:24 -0500
X-Google-Smtp-Source: AH8x226nV+OkrsaphZLf7ZUkX9AedcpQjNMx5dVQ1eJ/c9xfpPWiDRr4Tc4b0DCMffJY9+85/uNfIw==
Subject: Re: [PATCH 4.4 28/74] ACPI / scan: Prefer devices without _HID/_CID
 for _ADR matching
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20180129123847.507563674@linuxfoundation.org>
 <20180129123848.888319573@linuxfoundation.org>
 <ffdd5d23-0080-6b00-1b46-2b7952200ac7@suse.cz>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <bdb6b0ed-0c79-0053-ddd3-78da186fc33e@suse.cz>
Date: Thu, 1 Feb 2018 09:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ffdd5d23-0080-6b00-1b46-2b7952200ac7@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018, 09:46 AM, Jiri Slaby wrote:
> On 01/29/2018, 01:56 PM, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> commit c2a6bbaf0c5f90463a7011a295bbdb7e33c80b51 upstream.
>>
>> The way acpi_find_child_device() works currently is that, if there
>> are two (or more) devices with the same _ADR value in the same
>> namespace scope (which is not specifically allowed by the spec and
>> the OS behavior in that case is not defined), the first one of them
>> found to be present (with the help of _STA) will be returned.
>>
>> This covers the majority of cases, but is not sufficient if some of
>> the devices in question have a _HID (or _CID) returning some valid
>> ACPI/PNP device IDs (which is disallowed by the spec) and the
>> ASL writers' expectation appears to be that the OS will match
>> devices without a valid ACPI/PNP device ID against a given bus
>> address first.
>>
>> To cover this special case as well, modify find_child_checks()
>> to prefer devices without ACPI/PNP device IDs over devices that
>> have them.
>>
>> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> You seem you took this from SLE12-SP2? But where did you take the
> upstream commit SHA from? In SLE, I have "Git-commit: fdad4e7a876a2..."
> which is the correct SHA of this patch. The above c2a6bbaf0c is a
> different patch. So are your scripts broken or is this a manual oversight?

Not only the SHA, the whole commit message is taken from c2a6bbaf0c. But
the diff below is fdad4e7a876a2.

To clarify: upstream c2a6bbaf0c is in 4.4.80 already (as f4a42f8492).
The diff below is a fix for it with upstream SHA fdad4e7a876a2 (in 4.4
as 1fe277d48f). So the code is correct, unlike meta data.

>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> ---
>>  drivers/acpi/glue.c |   12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -99,13 +99,13 @@ static int find_child_checks(struct acpi
>>  		return -ENODEV;
>>  
>>  	/*
>> -	 * If the device has a _HID (or _CID) returning a valid ACPI/PNP
>> -	 * device ID, it is better to make it look less attractive here, so that
>> -	 * the other device with the same _ADR value (that may not have a valid
>> -	 * device ID) can be matched going forward.  [This means a second spec
>> -	 * violation in a row, so whatever we do here is best effort anyway.]
>> +	 * If the device has a _HID returning a valid ACPI/PNP device ID, it is
>> +	 * better to make it look less attractive here, so that the other device
>> +	 * with the same _ADR value (that may not have a valid device ID) can be
>> +	 * matched going forward.  [This means a second spec violation in a row,
>> +	 * so whatever we do here is best effort anyway.]
>>  	 */
>> -	return sta_present && list_empty(&adev->pnp.ids) ?
>> +	return sta_present && !adev->pnp.type.platform_id ?
>>  			FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
>>  }

thanks,
-- 
js
suse labs
