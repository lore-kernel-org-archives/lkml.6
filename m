Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoMjeihQN7zAqCa3jMxuI9yCEfY5gmB0KQwTYsHe8fu323Ya37aBUJ0tHixyDRZdakIChtW
ARC-Seal: i=1; a=rsa-sha256; t=1525393476; cv=none;
        d=google.com; s=arc-20160816;
        b=BRwFbMBi67fRAXzZGMCcdwnnQsR2gdPL6MknsqvZPVSFZbVLUnPePj67VzCr0IJK9x
         vWHrnOpSxlzdvPUacFLja8SbD1RHNTpAz6xqLuQ8DWTZXqmNvEDICtvg9XqJZHPnz8nC
         rOKcvcBQewrXCPoAUCMN/gGE20DiN9EZplvBWSp1QRWWmfNeG8AiUShJWhbBqwM1GnOE
         BB2L3a51FE+283lQYs9NvMa+FRIorRznj6YeXh9s3fiJKoow8XQDXmjPBJV6aG3gopmw
         G94JlaoZ+uqvb53VfFCX5H5zR7wQXFtreDlpishY5sBakUw2JGKZQ6YBe+pwIfBBlFKI
         txtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=yFukvqKnvgbch/y9l4T+Fi4lTGgP7USGygruQTfP/nE=;
        b=YAfrJRmzOVslAfXodmuEvFuLEttBqNGkZ80oIWDFva5NtKT8qLDo1PT0W1xrwWhYuQ
         dvRAsbMrezmUNZOztmvyx/c8cghm4wehKlYwR8osyk/Ow5Ea3x2D/gsCOPUIGkJ91oYo
         ShOKbVw9ge4v09DUPjLXh1z26s6KsTfM/+FSBYNh2PR8KA+KsMVF+jjenmWSkterVhKp
         bu89L/7hHwm1Scza1y6tn+xOfaOOfdHuo4zTI2zTJ0+fBFa/Y7KBJyWTrm2rAIFmWvdr
         CQKaMgVmIz8JAH47nMrMP6uOkpH36GrhzE3cNMi0XQMHAdNyavhoO+84YU7Ztqlabyh7
         b0Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones
 <pjones@redhat.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees
 Cook <keescook@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>
Date: Thu, 03 May 2018 20:24:26 -0400
In-Reply-To: <20180504000743.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <20180504000743.GR27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050400-0020-0000-0000-00000418C1BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050400-0021-0000-0000-000042ADE60F
Message-Id: <1525393466.3539.133.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040002
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1599490989690844519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-04 at 00:07 +0000, Luis R. Rodriguez wrote:
> On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> > Allow LSMs and IMA to differentiate between signed regulatory.db and
> > other firmware.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > ---
> >  drivers/base/firmware_loader/main.c | 5 +++++
> >  include/linux/fs.h                  | 1 +
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index eb34089e4299..d7cdf04a8681 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> >  			break;
> >  		}
> >  
> > +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> > +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> > +			id = READING_FIRMWARE_REGULATORY_DB;
> > +#endif
> 
> Whoa, no way.

There are two methods for the kernel to verify firmware signatures.
 If both are enabled, do we require both signatures or is one enough.
Assigning a different id for regdb signed firmware allows LSMs and IMA
to handle regdb files differently.

> 
> >  		fw_priv->size = 0;
> >  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
> >  						msize, id);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index dc16a73c3d38..d1153c2884b9 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
> >  	id(FIRMWARE, firmware)		\
> >  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> >  	id(FIRMWARE_FALLBACK, firmware)	\
> > +	id(FIRMWARE_REGULATORY_DB, firmware)	\
> 
> Why could IMA not appriase these files? They are part of the standard path.

The subsequent patch attempts to verify the IMA-appraisal signature,
but on failure it falls back to allowing regdb signatures.  For
systems that only want to load firmware based on IMA-appraisal, then
regdb wouldn't be enabled.

Mimi

> 
> >  	id(MODULE, kernel-module)		\
> >  	id(KEXEC_IMAGE, kexec-image)		\
> >  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> > -- 
> > 2.7.5
> > 
> > 
> 
