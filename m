Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZpjq32mle0YJWXtkR9fkY4Ybw7neFd2pdpMagbaK34ErSRaY4JWP0qxUDcyryMGK1W1xi2k
ARC-Seal: i=1; a=rsa-sha256; t=1526014841; cv=none;
        d=google.com; s=arc-20160816;
        b=jDBl7TdfzmLUnrhI229K7YhiwtlvQXsWCCxt4/gHyE2QGciHCKfeJ20Jh4PcAFQg6/
         qQm6JHUnjJXlxx0o8i1yz4VwNXq71tOGgeGUliy8ZvMPlYm0F0crfflXyc2ftquSOVh1
         XRlaumxlvjERg88WQDCZgotIlDLt+0YDfmPzkwklBtApehKu/80vIygt/R+rKRbyouq1
         +oMe7mC/bauYclbwFTXNOXo6BuRC/aWCOL/Ihu8iGKM6Wi+vyGD06/VTQty3djavElCr
         AhDZt9sHFTYhRwFhNzTIaanFLuEd5GCGiyk5830Qg+13T//41gjWAyun6mRY2curTFDA
         ZPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=WugGlV7yx3ik/VKr74n4sAAHmyx3Ei75DcvwJrhwUjQ=;
        b=lGtCfP0P9EL7PmQ1zHqGP2rU67KjzHIspFqjafYa3qOJP/E93+asCg0vg57Cm6fzE7
         fTP5ygNC48nO0Z3VG63Lb4+xnv15uy/wEW6uUMbYDHR+Fs3p7AKI6feIoqQ8WHYpO9FU
         QvM7QttBdCvSQmENjw2wLyYloE7w4lv0NEW2rad6vgNhI9Ez8GhsAOFCdzDndybapUIp
         UuT5aGEReAx1UYUUUCuh8S6yyREc0QcacAJVPN97cLP+46NtWLNEIy6WNDbY6iMjieF7
         XhILMHWCl12Gc2mqiNiuGRSlhzuVv46/1z1W3xWYXbKMcHlggmbpVEYt6XU4HCCYU9j5
         xlKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Jones <pjones@redhat.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Howells
 <dhowells@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Seth Forshee
 <seth.forshee@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard
 Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees
 Cook <keescook@chromium.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski
 <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 11 May 2018 01:00:26 -0400
In-Reply-To: <20180510232639.GF27853@wotan.suse.de>
References: <20180504000743.GR27853@wotan.suse.de>
	 <1525393466.3539.133.camel@linux.vnet.ibm.com>
	 <20180508173404.GG27853@wotan.suse.de>
	 <1525865428.3551.175.camel@linux.vnet.ibm.com>
	 <20180509191508.GR27853@wotan.suse.de>
	 <1525895838.3551.247.camel@linux.vnet.ibm.com>
	 <20180509212212.GX27853@wotan.suse.de>
	 <1525903617.3551.281.camel@linux.vnet.ibm.com>
	 <20180509234814.GY27853@wotan.suse.de>
	 <1525917658.3551.322.camel@linux.vnet.ibm.com>
	 <20180510232639.GF27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051105-0040-0000-0000-000004585B24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051105-0041-0000-0000-000020FC6DDE
Message-Id: <1526014826.3414.46.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110044
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600142538353439371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-10 at 23:26 +0000, Luis R. Rodriguez wrote:
> On Wed, May 09, 2018 at 10:00:58PM -0400, Mimi Zohar wrote:
> > On Wed, 2018-05-09 at 23:48 +0000, Luis R. Rodriguez wrote:
> > > On Wed, May 09, 2018 at 06:06:57PM -0400, Mimi Zohar wrote:
> > 
> > > > > > Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
> > > > > > would differentiate between other firmware and the regulatory.db based
> > > > > > on the firmware's pathname.
> > > > > 
> > > > > If that is the only way then it would be silly to do the mini LSM as all
> > > > > calls would have to have the check. A special LSM hook for just the
> > > > > regulatory db also doesn't make much sense.
> > > > 
> > > > All calls to request_firmware() are already going through this LSM
> > > > hook.  I should have said, it would be based on both READING_FIRMWARE
> > > > and the firmware's pathname.
> > > 
> > > Yes, but it would still be a strcmp() computation added for all
> > > READING_FIRMWARE. In that sense, the current arrangement is only open coding the
> > > signature verification for the regulatory.db file.  One way to avoid this would
> > > be to add an LSM specific to the regulatory db
> > 
> > Casey already commented on this suggestion.
> 
> Sorry but I must have missed this, can you send me the email or URL where he did that?
> I never got a copy of that email I think.

My mistake.  I've posted similar patches for kexec_load and for the
firmware sysfs fallback, both call security_kernel_read_file().
Casey's comment was in regards to kexec_load[1], not for the sysfs
fallback mode.  Here's the link to the most recent version of the
kexec_load patches.[2]

[1] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006690.html
[2] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006854.html

Mimi
