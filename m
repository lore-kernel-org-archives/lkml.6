Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224DuhnOqIBiX+77GE04GJncrpUzg2h54rFZZaEKRA9dNc6AzVjzqH+NluuRFqFv8BpFaev7
ARC-Seal: i=1; a=rsa-sha256; t=1518066918; cv=none;
        d=google.com; s=arc-20160816;
        b=kqCAdL+xuAMe0E+MpzuKkv5Oe51ncMuylwv0decl3ER5+AFtODeaEtHPfZzBupQNyQ
         qV+WdFljo2OWfcy5uWfkJuH3+Q9KHGmLZaVwYWk4sCMYPz8/Wu+SjcLI3ngz+VydqMgp
         8TH+Cq85242rPZlDXRJ/yOf5mSi74CG9xL6g77bTS+b3BLaRX/w7vycqI7eWL4uAfDvv
         bA3OpwoIuUOgXegk2uzxvRaZo/EOKYnIgQ7lySzZXC0O5YxrthvIaw7tIoMfmgyZ3qU8
         Cu8tCWyMnYDCywoXtADWZPrFo40wG6NEPUchDNJTWLzZmPdcRb3B1AjDP7uXDA/ZxDr0
         b8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=f2IAXxDUvoua5jLod1P0s8dUz704/qVqpnbXn682L44=;
        b=GK1XjWLqAMqL5tecz2gKCE8ITPwv87Yjy79zCaiIyTKZyTPYBMeCcl530wrf3SN28K
         dC6WmCoyWS+7o4JdUffjWMVH3iYZelytKD3slvuasrvrJDs9fbL3Y2gsLPI9T/lDcAAZ
         UAyDL8VP4S7/fiAL0R9So4vEvxqKSYa9WEoTbg/SQgwO7W8hStvzyWuoi6UF3aYNv3c6
         up6f9yXniFGnALNhE3NXpQQl5u3QKOzjyrBJz2+JMKmEWts6p9qD3xw+ODn9t1NkVgUV
         r5nO+W1ryJ0RilUZt2Kth2O06T36xXl3TYmgI7fUzhmN0GV7ZZ5k9iSiLDlJPMGf7BQ4
         exHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=V4H6N167;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=V4H6N167;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbeBHFPR (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Feb 2018 00:15:17 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39096 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeBHFPQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Feb 2018 00:15:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAEUSe79T9Miw==D6u3Wx-EMymzP8aABWf_Lfqb9KP57WZgU0ZQ@mail.gmail.com>
References: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
 <CAOuPNLh17DH2nZL86WSWKUKQJr-Z1EY+ZqRFsXRTqK-XMtyx2g@mail.gmail.com> <CAEUSe79T9Miw==D6u3Wx-EMymzP8aABWf_Lfqb9KP57WZgU0ZQ@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Feb 2018 10:45:14 +0530
Message-ID: <CAOuPNLhwSaG2K2X_xE4PzaXQFWzNLVN=F+dtqPg=iBduWzRxTg@mail.gmail.com>
Subject: Re: [PATCH] selftests/android: Fix line continuation in Makefile
To: =?UTF-8?Q?Daniel_D=C3=ADaz_Rodr=C3=ADguez?=
        <daniel.diaz@linaro.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1591808536838094401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 10:46 PM, Daniel D=C3=ADaz Rodr=C3=ADguez
<daniel.diaz@linaro.org> wrote:
> Hello!
>
>
> On 7 February 2018 at 00:01, Pintu Kumar <pintu.ping@gmail.com> wrote:
> [...]
>> Thanks for your patch.
>> However, I have copied this Makefile from
>> tools/testing/selftests/futex/Makefile before modifying it.
>> If there is a problem with backslash then the same problem must be
>> there in futex Makefile as well.
>
> There is. Patch coming.

OK

>
>
> [...]
>> Also is it because of make version ?
>> Can you check your make version ?
>
> It's make 3.81.

My make version was 4.1.
So I did not face any problem. I guess this problem is fixed from make
version 4.x on wards.
However, for backward compatibility we can include these change.

So, its looks good for me, however someone else must approve it.


>
> Thanks and greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
