Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412576; cv=none;
        d=google.com; s=arc-20160816;
        b=kuYcr7KZ/29yWzp6JxjUQ5el7tUJ2TW1/96IcA/7F5DMYfhkigSbA6bJkBvt07ESiK
         3n9662dmXDEwxJKjWmoLuH3nMvrifuUujSAsevYCeMBykog0eQl+LuTbCgUPs1tPn+K0
         f1DwNWN7IX3UV5dDMGjSXA50oYfTY0VsayZTR2DWWWeDZhsotMYu4yHchcyYON1BaISt
         vbd9zDSRT4azFRx2mkb7WudKLZS+A/d1Q94QgY+hNy6MKfEptQpznYqhTXyLyNZmO5jf
         WHdWfaHJwOVTjKE3giYVI2e47JBWeMJJ7FvR5OJa6SdBmx1jCtBeIOP40fpsaYuosYVV
         57ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=BcFz18amMgm9LDLm6VxIr3GEcZr68E20vphi7zAfEYk=;
        b=VSC2AjlnavQZiP8A4spaDEky0tvV+vrCb9jAE7jL0bBdwZp5eqxZLqJMFhEAEmR9y/
         m/oq7sBk/j6qXfo6n6/oLJrmFl7xYfsibnrz4h964ufpWwNygDMvO30kFlt7PE4FNkE0
         bT8+24KPyPrpVp4euFaFXm9eU29OTEQ3NwOrxekBcLbQWIkjQlpvs+y4bgQMxh26pT8A
         ySsWMJfrH/TjXobEdVNU2U2i+GKB3+yONT1Qx7pspObwgfzr3DHBJIn6CAn3el+/8Sr7
         qa6Qn7lsM8Tj5MzCKg+Som2DE/ZIdpYdUUW22rVva56MNJV+zTlkJ12+ofBSSnU1JP3r
         rVmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jJzTpxoW;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jJzTpxoW;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x224jsV5RXSOggcVaPjB+XkjTUghvxLOO/qVjeieSrTIAklj+m9GJndiQcjHB44K35LiYJQKlsA==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 00/10] FSI enhancements for v4.17
Date: Mon, 12 Feb 2018 15:45:39 +1030
Message-Id: <20180212051549.8575-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592170985110788689?=
X-GMAIL-MSGID: =?utf-8?q?1592170985110788689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Greg,

Here is a set of FSI patches that we would like you to merge for 4.17.
These have been sitting in the OpenBMC tree for a while, and some had
been posted upstream for review in the past but not merged. That is to
say they have seen plenty of testing.

Cheers,

Joel

Christopher Bostic (3):
  fsi: core: Reduce console output during normal scan
  dt-bindings: fsi: Add optional property no-scan-on-init
  fsi: core: Add check for master property no-scan-on-init

Eddie James (1):
  fsi: Fix one and two byte bus reads/writes

Jeremy Kerr (6):
  fsi: Add fsi_master_rescan()
  fsi: master-gpio: Add locking during break and link enable
  fsi: master-gpio: Add external mode
  dt-bindings: fsi: Add specification for FSI busses
  fsi: Match fsi slaves and engines to available dt nodes
  fsi: master: Clarify master lifetimes & fix use-after-free in hub
    master

 .../ABI/testing/sysfs-driver-fsi-master-gpio       |  10 ++
 Documentation/devicetree/bindings/fsi/fsi.txt      | 151 +++++++++++++++++++++
 drivers/fsi/Kconfig                                |   1 +
 drivers/fsi/fsi-core.c                             | 129 ++++++++++++++++--
 drivers/fsi/fsi-master-gpio.c                      |  89 +++++++++++-
 drivers/fsi/fsi-master-hub.c                       |  27 +++-
 drivers/fsi/fsi-master.h                           |  17 +++
 7 files changed, 409 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-fsi-master-gpio
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi.txt

-- 
2.15.1
