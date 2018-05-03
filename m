Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZpB7/hXPIC1XMZdpuxO/iWBxwSaupgHvJg94l1W/Qnxzi/7s2FXNpVzSFzKkDsVwQw9pw9t
ARC-Seal: i=1; a=rsa-sha256; t=1525388582; cv=none;
        d=google.com; s=arc-20160816;
        b=Q3Nk4GRG5f8a0yVOf2DDay+s49DRLBOuJecrnJZRmNCkE54APMj34Pk+0iXhW8wbtr
         9R/JrUNycYl0asmURJoXklmjWyHudo3DRAODKSRgPhE70ePsFcz8LB0Eo4mAMwPiFPRK
         ZxMmguRpS+hgory4W3EE88BkbUOfJY/ofkzwOlNm1lE3WCSoNibAbZbfffiIEF6xfjPb
         XuJ/3U+PaGXeE8xTnHQ/45GhRP6a8PvnMwP+NUmtuCZGbLBXeCX4IhMvtpAKXjKfFuTj
         ORhCCMtaWXj1qPZ4zPR46h3dhJAVoXw7Tsctzp7pijtRkmR3ewFAgqWRbUQQ8w4ZbWe8
         ffmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=UZytqJS86/Hq21uBL89VA+cG7ZiXXnFoOkEdhDT23qM=;
        b=FkvrZrrwFjsiabia0WabSMKXjMd3Cs7oI6uxFSDqzSy/c39guSyJmoFhWCOiWSlOjk
         xLDeHIYteNKXlBXeUKwwIMC6DptxXzE6W2taiFiOU3nus2BGQssYtQdsnv+qS8gsDmE2
         pMqNiw2oupQhfedidDrspBlqBQx3KElz8yyWe1bHZCm0s0daKWy4ir8BkSkbMJEoVkCK
         XNtDQjJrYZiDqNs/M8GDkyq/9CxLUQysDTcdAPQS9TuwWkvV4fjXKiRSbD5I5OG0iB4W
         nKEOdM3sxQdNsDPZ3iwwf4VX7gXYZBDDeDbXfWxCDl22ThGP/fwW6lsGNXgN6W8mnqo9
         Rh8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel
 <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Peter Jones
 <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, Will Deacon
 <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming
 <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Josh
 Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
        mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel
 <arend.vanspriel@broadcom.com>,
        Linus Torvalds
 <torvalds@linux-foundation.org>, nbroeking@me.com,
        bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
        Kees Cook
 <keescook@chromium.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module
 <linux-security-module@vger.kernel.org>
Date: Thu, 03 May 2018 19:02:43 -0400
In-Reply-To: <20180503222329.GD27853@wotan.suse.de>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	 <20180429093558.5411-3-hdegoede@redhat.com>
	 <1525185374.5669.49.camel@linux.vnet.ibm.com>
	 <dc122066-9973-a1be-3456-6d6181a8fc9f@redhat.com>
	 <1525202847.5669.64.camel@linux.vnet.ibm.com>
	 <20180503222329.GD27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050323-0044-0000-0000-0000054EBC2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050323-0045-0000-0000-0000288FE53B
Message-Id: <1525388563.3539.97.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030200
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599485857896041441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-03 at 22:23 +0000, Luis R. Rodriguez wrote:
> On Tue, May 01, 2018 at 03:27:27PM -0400, Mimi Zohar wrote:
> > On Tue, 2018-05-01 at 21:11 +0200, Hans de Goede wrote:
> > > Only the pre hook?  I believe the post-hook should still be called too,
> > > right? So that we've hashes of all loaded firmwares in the IMA core.
> > 
> > Good catch!  Right, if IMA-measurement is enabled, then we would want
> > to add the measurement.
> 
> Mimi, just a heads up, we only use the post hook for the syfs fallback
> mechanism, ie, we don't even use the post hook for direct fs lookup.
> Do we want that there?

The direct fs lookup calls kernel_read_file_from_path(), which calls
the security_kernel_read_file() and security_kernel_post_read_file()
hooks.  So there is no need to add a direct call to either of these
security calls.

Mimi



  
