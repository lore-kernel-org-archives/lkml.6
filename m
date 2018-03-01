Return-Path: <prvs=591584a1f=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AG47ELvXG3OqhBWmBO+Hxb5nQUdhQt3AK6/T3EK1qQvnIIqv/Q3NVem7WGubrLs5hclFDkC68IgL
ARC-Seal: i=1; a=rsa-sha256; t=1519901291; cv=none;
        d=google.com; s=arc-20160816;
        b=MjwvL7n7Srst/0ro6iAQbxDy4F6+UFjto8l765jjE6UcoRu7a7YtWuZSYfbVmgm+Fu
         uouARM9MEN4YztVorDnXVPUNGa+r9A9hlhYE0r2B5U4kEx22GTHLvdsZ4TMZot4O6VRA
         gkE8nB7lW8+hAFM/uyh6kpmbMcvCu4O8mxbvtcIEHAOumGRIGTiQONNA7CpeqsgZ86/w
         +2DVam6qu7W+9UZskKT7cP5cjyXtXnjxhUSRxgxY3R+v1Eb2fZvUh+YHso5L/igjh5l4
         qw74DfuPpgwBRSQutjChBI+5lW/cPzGFNF7go9m0squjm7pWiwTcjHsLV1DaEIT0h70x
         vfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=KQ9992WSDwJo2Q/yZF5j9pQz8SJ1eP5jApWmtdYaexM=;
        b=PS9ydkJivKD+K//JlX0E0LGfOF9kV8V2OCFQdX05GEDSesDoRNEmGgHJAH0OSRsi2O
         CzTnPDYBZZmwmmQPdapxDl1SsRaEj941nhqHZay/C5OBn3yw0SBZWyXsJns4D05J2nY0
         U/cglEfjFefQm7DtszDStvdCHH8D2GYsdQNQmUqctVikcx5ambyWB/kbe/DntnbiTGZi
         1UHTNLOM4XP+A0nqH+MY0yyd0qeRWQzi1NekYxjUFx9TbICbaj7R0A7VEYKl74f/Omo2
         99YO5HM5MTpVChfyCuwnaeoTWDIkojKlNfMTyaDnnK3KnN66Jzc4FhxvHQJUB+FDYvET
         YZLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=lzFh7XpX;
       spf=pass (google.com: domain of prvs=591584a1f=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=591584a1f=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=lzFh7XpX;
       spf=pass (google.com: domain of prvs=591584a1f=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=591584a1f=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.47,408,1515427200";
   d="scan'208";a="73201583"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	subhashj@codeaurora.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH] scsi: ufs: sysfs: reworking of the rpm_lvl and spm_lvl entries
Date: Thu,  1 Mar 2018 12:48:05 +0200
Message-Id: <1519901286-17496-1-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732016815637504?=
X-GMAIL-MSGID: =?utf-8?q?1593732016815637504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The functions related to the rpm_lvl and spm_lvl sysfs entries were moved to
a separate file as part of UFS device management patchset. During the review
phase I was pointed that these entries implementaion could be improved.
The each file output was split to three parts:
    rmp_lvl - rpm_lvl, rpm_target_dev_state, rpm_target_link_state
    smp_lvl - spm_lvl, spm_target_dev_state, spm_target_link_state.
Each new entry has a single value output and doesn't reqire additional 
parsing.
The information about new entries and possible power management levels was
added to the corresponding ABI file.
The on-write behaviour of these entries wasn't changed.

Stanislav Nijnikov (1):
  scsi: ufs: sysfs: reworking of the rpm_lvl and spm_lvl entries

 Documentation/ABI/testing/sysfs-driver-ufs | 67 ++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 92 +++++++++++++++---------------
 2 files changed, 114 insertions(+), 45 deletions(-)

-- 
2.7.4
