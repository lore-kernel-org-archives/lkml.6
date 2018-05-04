Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZpISHUhPI9sF+9/R9FLemM38hNiM1zE5Frlr1K37Bg4EyhdQ2KCI7+5BGqfBLn3TqR9u9V+
ARC-Seal: i=1; a=rsa-sha256; t=1525394210; cv=none;
        d=google.com; s=arc-20160816;
        b=GsSFRxK1gMUEFzBOvF+r8ghuztLsABh06qT2Yr3coBpEVjYrcJ0eD2tvI5WwT6sAxX
         m7OCq6cOn5h17FRIWL3GBx8clhoDFiOMfcRHNYhwOpKkcG9KqTjvEaugC3okMgDl6izJ
         +TrfH4oy/A8BYvY1kHyXqQzUEP9lx4vi+G70HKOA4NxSfedmXlSEVGpV8ZaUfKuHhKjf
         c79yEjduAsIHHLHn3mZfsG6Q+Uol9V8qxuGNMlmGyKNBJfaBdOPVWXrd7n8et79KfByU
         YiG35EZly+4aQDFCT8WglET+YrOi/GhSPhKZmgdVGZbSiXU/cGnEO+vW5+l+f8gBzXUj
         jO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=nS9bYFiEstG8bfrFxSyg0oTPF3HTgqxTYEn9jX9CznE=;
        b=czMotqq8588YIQy+rh5aOWv4nVVHcjrIaqXtq1NVTJgBO+EuknSMR3RnNmH6N//oWh
         MXQ9knfOWCfwPByknXNW7oFa+SepB/7dD1Ae5H3pyHrFnYS+gacH4ajNoXt4GA1s18x5
         UnJ623soTxOlkvNpf1M0s7gzPCXEYC8NN0YKrPSjrK1g6J4hBY6xZkgcmlIdjCfa1yPi
         c8bAPNsiGpymMkgi/ZGsXrVFSoULYm71K66qJhnvsxfVlbEDmUv+S1xNwoGoPvm8QAcc
         O6WYZrdf1+D49BBnc6MU5AiMZtVv4qT1b4RK9g11hOIF7F2i2asjAZflGSGxttymrcOn
         MOgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 1/6] firmware: permit LSMs and IMA to fail firmware
 sysfs fallback loading
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones
 <pjones@redhat.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees
 Cook <keescook@chromium.org>, Matthew Garrett <mjg59@google.com>,
        Andres
 Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 03 May 2018 20:36:38 -0400
In-Reply-To: <20180504000258.GP27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1525182503-13849-2-git-send-email-zohar@linux.vnet.ibm.com>
	 <20180504000258.GP27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050400-0020-0000-0000-00000418C265
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050400-0021-0000-0000-000042ADE6C3
Message-Id: <1525394198.3539.143.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040004
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489630660050876?=
X-GMAIL-MSGID: =?utf-8?q?1599491759230793343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-04 at 00:02 +0000, Luis R. Rodriguez wrote:
> If you can add Andres Rodriguez <andresx7@gmail.com>, and Greg to your Cc list
> in the future patches that'd be appreciated.
> 
> On Tue, May 01, 2018 at 09:48:18AM -0400, Mimi Zohar wrote:
> > Add an LSM hook prior to allowing firmware sysfs fallback loading.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Matthew Garrett <mjg59@google.com>
> > ---
> >  drivers/base/firmware_loader/fallback.c | 7 +++++++
> >  include/linux/fs.h                      | 1 +
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 31b5015b59fe..23d2af30474e 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
> >  
> >  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
> >  {
> > +	int ret;
> > +
> >  	if (fw_fallback_config.ignore_sysfs_fallback) {
> >  		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
> >  		return false;
> > @@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
> >  	if ((opt_flags & FW_OPT_NOFALLBACK))
> >  		return false;
> >  
> > +	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> > +	ret = security_kernel_read_file(NULL, READING_FIRMWARE_FALLBACK);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return fw_force_sysfs_fallback(opt_flags);
> >  }
> >  
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 760d8da1b6c7..dc16a73c3d38 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2810,6 +2810,7 @@ extern int do_pipe_flags(int *, int);
> >  	id(UNKNOWN, unknown)		\
> >  	id(FIRMWARE, firmware)		\
> >  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> > +	id(FIRMWARE_FALLBACK, firmware)	\
> 
> If you're going to add this perhaps FIRMWARE_FALLBACK_SYSFS as we may later
> get FIRMWARE_FALLBACK_EFI.

>From an IMA signature verification perspective, both are buffer based.
 The file signature is stored as a security xattr.  Without a file
descriptor, the kernel cannot verify the firmware signature.

I don't have a problem with defining another enumeration.  Perhaps
other LSMs will want to be able to differentiate between sysfs and EFI
fallback methods.

Mimi
