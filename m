Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AG47ELvGNT4TthFL3WiQ66ds/jF4zysfg5w/yR6c34eAyvtqLfRhasygYEDKSXeUDIijakBeovN6
ARC-Seal: i=1; a=rsa-sha256; t=1521107737; cv=none;
        d=google.com; s=arc-20160816;
        b=a7DCQBFn8aE01j5WTeOFCNW5vL704rcUz3j6Nt4JeyMZmxLxP60DDTCXNbjYM7G+Ey
         XGhWosrffJDZRsQo5qsO2ecJyUh6fTXJVcJwqWmExKBA3V6UKfoRJ/3lIIpIUmcbr4Wv
         2COMp/UMnaJCpr9+NfrabMFeHVBfFaWiLEesVjj2ML8wOpGTb8sTXnGiPf1CTodsO9au
         mSfXPNmn4tSJT1y6hk1ZwWxzw5Q1cH11BITuUMdydzqKD8ril0CTJyAkLJB5V3FssP+k
         6ly2llTS8uIiTIYwc8lUUvfyRBnGzTSZuTR0cAuI92CO73u5QhomhqNDsAGbdQ9nGD/l
         p/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=RkJgiXnN30De5EDhwIPHIQQrKLRNZ7y/6bP3WMI956o=;
        b=H0hLJQc4eVhXucq1EIklKgAlvQnuPaEekLrd+VG8LukLt+1qecrF0tcXytm5lB80lR
         UICa1DR0Rwlf2BPnGRVfJ9XTPCq62Qnqa9gFqkwb+9q7bcQABL5+FhzPiCfNBXIDzkVX
         FIOP3VfKNVmkCBXqhTBIFfxxcHOmakNzBRRG/CrvqMZF/jhbc2fpFVcDElflhUB9E4XE
         DSgj1gP/uR0bTaom7G7Q+OnbO+3MK9yxCbNHekccn2tTVgA2j7q+KQuYY0fcfOJAeejq
         VozeFP5DmiiQ6vijETt+G+uo4081GN9cmZLnk4W3Y8sxrF5QU8Hq0FrbFoxrxdY+I2jT
         6fwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Arend van Spriel <aspriel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Arend van Spriel <aspriel@gmail.com>
Subject: [PATCH for-4.16 0/3] drivers: base: revise coredump ABI
Date: Thu, 15 Mar 2018 10:55:22 +0100
Message-Id: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997066870857843?=
X-GMAIL-MSGID: =?utf-8?q?1594997066870857843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not sure if this can be considered as fix for v4.16. Upon submitting
the driver patches I received valuable feedback that I would like to
address with this series.

The patch apply to master and driver-core-next of the driver-core
repository so you can take it either way.

Arend van Spriel (3):
  sysfs: improve devices-coredump description with user-space
    perspective
  drivers: change struct device_driver::coredump() return type to void
  drivers: base: remove check for callback in coredump_store()

 Documentation/ABI/testing/sysfs-devices-coredump | 14 +++++++++-----
 drivers/base/dd.c                                |  3 +--
 include/linux/device.h                           |  5 ++++-
 3 files changed, 14 insertions(+), 8 deletions(-)

--
1.9.1
