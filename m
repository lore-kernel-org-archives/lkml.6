Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055233-2-2182723193090000560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055233; b=QmjSLkUXW+rjnsq11AYIkH2jw1AXIGuGj94fh8r/A05uFJ9
    /0w40Q5hGEVsS1jbfmmYV26nqU8a3fT2FQ53dCSwtruH5YR77qH3YqOd2tv0+Ic7
    BMIfvzVGjqdv6XXjFRK2VcXU6V39mDbWruxLa3Qjfboi755n3qAxmOz6Az+HVbw8
    wRkEZgZ8bHF37mWa/sakKEX0gz3xugTCrQJkqgjEgQGS1a3UPe7MlpCEoSkezq+4
    /FChJEUMDFMMV6OOR8KcKoli5InjkCvYzZRUzFQYGN6iVwLIxY/2sqqQ8//w4fyJ
    PFmWrLlhCX/yojXlekoP2I8v9dGoobvquh442Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055233; bh=c
    4uzQEwtcvZkFNfsucZIDqxmRWBBhxn1eerYbCo0U54=; b=Y1LbyAclgcLIlHLVQ
    4GUUtCqF4w61IJBcqwa2hFNTuD+aoNUaubHuGtkM1s6Fk7A4ZLTNHOhekB4czCdM
    gOhARwK9stLYLyxjBlH5d5t0k436Fm55yqqTFEKwgqN5n5BF2X2HHdOPc7BgqtzX
    Gvf+/CpMra+rCfaVRHd2blpEOOfMhajh6fX7dVz/o0BlHUqVK9l2uA/7MtkAV0AK
    0yfOwWxaeAdspXpL3RvZBDYdGBT9lOqf/G1ghN5S1odbx4AVCV8SbfsBwcMI8w72
    rXHSY9i9/R6JxwiWrR5hPkwSeWPNGajLzTJWbNMk4A20bk9jkscDFxdE3bxW7Th3
    A6IFw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JxFRQXSy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JnkeeJL6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JxFRQXSy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JnkeeJL6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvDCWX8BxtsrvaBwnvuuM8JtZxFyQskCYl3Z+ByafQg0jYGBj4zeJ2e28GkUbi1Po7SFKGkog==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 0/6] staging: rtl8712: fix coding style issues
Date: Sat,  3 Mar 2018 11:02:30 +0530
Message-Id: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix issues found with checkpatch.pl to conform to the Linux
kernel coding style.

Changes in v2:
* From and Signed-off emails were not same in v1.
* Added detailed commit message

Arushi Singhal (6):
  staging: rtl8712: Fixed 'tabstop' coding style warning
  staging: rtl8712: match alignment with open parenthesis
  staging: rtl8712: Remove multiple blank line(s)
  staging: rtl8712: Added spaces around '+'
  staging: rtl8712: Add spaces around '|'
  staging: rtl8712: remove unnecessary parentheses

 drivers/staging/rtl8712/drv_types.h                |  2 +-
 drivers/staging/rtl8712/mlme_linux.c               |  2 +-
 drivers/staging/rtl8712/os_intfs.c                 |  3 +-
 drivers/staging/rtl8712/recv_linux.c               |  4 +-
 drivers/staging/rtl8712/rtl8712_bitdef.h           |  1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  8 +--
 drivers/staging/rtl8712/rtl8712_cmd.h              |  4 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |  2 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |  2 -
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |  1 -
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |  2 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |  1 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |  2 -
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |  2 +-
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        |  1 -
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |  1 -
 drivers/staging/rtl8712/rtl8712_led.c              | 70 +++++++++++-----------
 17 files changed, 48 insertions(+), 60 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
