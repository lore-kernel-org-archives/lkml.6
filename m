Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227zMd4c7rlkQvkqNpEZtI2jv3NoX8Rz+e+Fx/Xt5by/3lyh3g9IZX40iuAwsgIYmd+Eb+n3
ARC-Seal: i=1; a=rsa-sha256; t=1518469818; cv=none;
        d=google.com; s=arc-20160816;
        b=HdMklledh8uLV2F1pTANrrt6cmHUlmpMxD7itrgsuOXRB4lB7X8VLnkeX4eixV+VSC
         Wjg/wTNGVchLMbdAmVXnV4Xettx2ABFVDEx5mb/0kG7sXFo6Ies9Qutgjxid2iXkzLV9
         ehpjkVZMBIKQ3dsX+74Rt+GGw1DEceUuceTW5/INJZLI2cXJDLDtH3uQ3Yi033H0aiFV
         xvybY6tDWYklVOLPlzaC4DX5bcUcMiSefurUrXSWehx5wjLwmVZe/PKWGptsQL9MhKAj
         Fdo/ma9UWNh5ndgiBoJBc2A1i/T4oKSAPBcaCutHd1coqdoSQ0JY7IgRpBd4DgLl0Y8t
         e5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=lpBnpvTUYFOCa92KUHUZqUfHwRyi6BUOjwm+wA3TETk=;
        b=sCBW4mxO0j0VQrXMJrq2aRMlbjU1KuWQzJbBG+hFKggd0b84KnOBjjsYWIMlus69Wn
         +swlzSzXqhXAY8QOicHsZ5DhDqvwaLSf5SwBvgTOvmk1kthn6OEip5judxhVzZnsGelI
         uCSSGprv2oPA9unBzSVMTdGl7zggncxNwniieEXr8RVdXZlINkChOmf14+9jiIQxkIsb
         fPquTE+QLk7DigzdVb/nFZST3VfFJ++KTorq/AIbpqp9jw7Sh2ZWCe0mbVx5Y+J3IPhB
         EzclmRHZXkREeUxNUmC/yFPA8+yS49bD39yE5WyyGxNXKmWHynR4gRbzMeffHSa1krMC
         yWQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:09:25 +1100
Subject: [PATCH 0/2] Two lustre bug fixes
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151846966702.17168.15765227765350491300.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231007440916021?=
X-GMAIL-MSGID: =?utf-8?q?1592231007440916021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These patches fix 2 issues I found during testing.
Together they cause lots of path-name-lookup syscalls
to return -ENOMEM.
The first bug fixes triggers and error
The second bug fixes causes that error to be reported as -ENOMEM.

Thanks,
NeilBrown


---

NeilBrown (2):
      staging: lustre: fix inverted test on strcmp
      staging: lustre: honor error code from ll_iget().


 drivers/staging/lustre/lustre/include/lustre_lmv.h |    2 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
Signature
