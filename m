Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoMZ7CyDfWMffwi1pogOKTrBGIfOjItnKTmjR+cf5vaueFkKntARGX3sEoz7Gke4Q/mLwN6
ARC-Seal: i=1; a=rsa-sha256; t=1526349778; cv=none;
        d=google.com; s=arc-20160816;
        b=pQXsSaSXh1Znx/L9BJeq1aIPtHltMjbCKIEQLzG6+azXVw2l/ChLChfGI/x8mycUCT
         4pRYUwFYGPksNy0tJNmQGIpjeF90xBDPB+JnIb/3BLgaLRg/NMVWo6ZHK3VnT//yIWKt
         tsiVhXGDcmJEb+xS3MeDYk8mGIqs0A9nJTvjmcf+AcgeHQabGzyIttYdiUQsEsjMmaC7
         ZsTWTS83SQCHDVh8ZiGC6tQTve0PwMzume9Z30efx8Lvz+uo/dYzjaxwhy7rzVkg5CoX
         5wtjx/QS4GYdS3Ym6uwv057N5EUiPVM52Nh1ZFHACHqpR474SJ9d2ML/9+s6wk/rRu4F
         ZfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=cM0C2e4t99/apY1frVuYXfsrFH79ztN3kOLOHLEnHdc=;
        b=xeMkKsZhyAYgIPzDB6Ktf/RwkEGiZm0dxhp3b7DLmd9PihP+74k5hs+5xN4WN9s3vE
         nHsXS+VmmVQ0Od19wcvbsRst0PzBwkqEgKsYy80++2nPhsu/8mQtFYaoHk35W8TqIAv+
         eRIIGQRJj/HkZ6Q0YJdagg3dRrtyZZLcxTe6+vGpd+5ilW+NlmasI7UBj/UA6rDiPU8U
         /oItXHtpeftI3B78bSNt7myY4P3+9QxGjhVPrpTTBs+MUaLK4IpIKvfTMpPKpsM3cQf/
         AfM58bj5NWgQpmQLD8d00dnDjnNrDVcLjXCpNd5DWl2HUU0GmFFHuyf+0bT4u0QAffYB
         fB7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Harald Hoyer
 <harald@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn
 <jthumshirn@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller
 <davem@davemloft.net>, Jessica Yu <jeyu@kernel.org>,
        Al Viro
 <viro@zeniv.linux.org.uk>,
        One Thousand Gnomes
 <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter
 Jones <pjones@redhat.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Howells <dhowells@redhat.com>,
        linux-wireless
 <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Seth
 Forshee <seth.forshee@canonical.com>,
        Johannes Berg
 <johannes.berg@intel.com>,
        linux-integrity@vger.kernel.org, Hans de Goede
 <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees
 Cook <keescook@chromium.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Date: Mon, 14 May 2018 22:02:31 -0400
In-Reply-To: <20180514192853.GM27853@wotan.suse.de>
References: <20180509191508.GR27853@wotan.suse.de>
	 <1525895838.3551.247.camel@linux.vnet.ibm.com>
	 <20180509212212.GX27853@wotan.suse.de>
	 <1525903617.3551.281.camel@linux.vnet.ibm.com>
	 <20180509234814.GY27853@wotan.suse.de>
	 <1525917658.3551.322.camel@linux.vnet.ibm.com>
	 <20180510232639.GF27853@wotan.suse.de>
	 <1526014826.3414.46.camel@linux.vnet.ibm.com>
	 <20180511215250.GJ27853@wotan.suse.de>
	 <1526302692.3898.145.camel@linux.vnet.ibm.com>
	 <20180514192853.GM27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051502-0012-0000-0000-000005D695D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051502-0013-0000-0000-00001953AF90
Message-Id: <1526349751.3937.78.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150017
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600493745019146930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-14 at 19:28 +0000, Luis R. Rodriguez wrote:

[...] 

> > At runtime, in the case
> > that regdb is enabled and a custom policy requires IMA-appraisal
> > firmware signature verification, then both signature verification
> > methods will verify the signatures.  If either fails, then the
> > signature verification will fail.
> 
> OK so you're saying that if CONFIG_IMA_APPRAISE_FIRMWARE is disabled you can
> still end up with CONFIG_CFG80211_REQUIRE_SIGNED_REGDB as enabled *and* a
> custom policy which requires IMA-appraisal for the certain firmware signature
> verifications?

Right



> > There are two problems:
> > - there's no way of configuring a builtin policy to verify firmware
> > signatures.
> 
> I'm not too familiar with IMA however it sounds like you can extend the IMA
> built-in policy on the boot command line.

No, there are a couple of policies predefined in the kernel that can
be loaded by specifying them on the boot command line.  A custom
policy can be loaded later.  Only after specifying a policy on the
boot command line or loading a custom policy, does IMA do anything.


> > - CONFIG_IMA_APPRAISE is not fine enough grained.
> > 
> > The CONFIG_IMA_APPRAISE_FIRMWARE will be a Kconfig option.  Similar
> > Kconfig options will require kernel modules, kexec'ed image, and the
> > IMA policy to be signed.
> 
> Sure, it is still unclear to me if CONFIG_IMA_APPRAISE_FIRMWARE will be
> doing firmware verification in userspace or in the kernel.

The kernel is verifying signatures.



> > There are a number of reasons that the kernel should be verifying
> > firmware signatures (eg. requiring a specific version of the firmware,
> > that was locally signed).
> 
> Oh I agree, Linux enterprise distributions also have a strong reason to
> have this, so that for instance we only trust and run vendor-approved
> signed firmware. Otherwise the driver should reject the firmware. Every
> now and then enterprise distros may run into cases were certain customers
> may run oddball firmwares, and its unclear if we expect proper functionality
> with that firmware. Having some form of firmware signing would help with
> this pipeline, but this is currently dealt with at the packaging, and
> noting other than logs ensures the driver is using an intended firmware.
> But these needs *IMHO* have not been enough to push to generalize a kernel
> firmware signing facility.

In order for IMA-appraisal to verify firmware signatures, the
signatures need to be distributed with the firmware.  Perhaps this
will be enough of an incentive for distros to start including firmware
signatures in the packages.

> If CONFIG_IMA_APPRAISE_FIRMWARE is going to provide this functionality somehow
> I'm happy to hear it.

The functionality has been there since commit 5a9196d ("ima: add
support for measuring and appraising firmware").  The
security_kernel_fw_from_file() hook was later replaced with the
generic security_kernel_read_file() hook.

Mimi
