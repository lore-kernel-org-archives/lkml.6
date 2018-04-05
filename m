Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx4/qcbUPBfGaEoloPKqq9EVM/WBVLUVZLmKBpYi4vWJgYlgzVtUurVhgGZlqfv28YTgG1S6R
ARC-Seal: i=1; a=rsa-sha256; t=1522962754; cv=none;
        d=google.com; s=arc-20160816;
        b=iCALLUjthzMeVec4dPdPuhpQWLNPUkNHwejSJAYEx14AhRE2ga747wAUQBT+kAdGrC
         MJFecTfCHDjPa38OBMI6sHBZKNZi9DBSEEZg7w7/kn04EzzlxuWCrkSUoIZFGlQoGMwv
         RXLVZMHs+zgJRsn7vbE50RqBovZeVQIPu0ZeHtW87tOx4fhvAD74tIPYRTs/1b6Tc8EJ
         N73aA+dzzkjDmRGbiPBV0iSATpO4XKHSyCoJg+h35BaObsZE2x6Qox5NdjdG6b6hTBgm
         ow1dEMKFThFveZ32Iepeo7hUN/2g+TDUQy/fo7K4MwvvS77BgQe7qe2TbWIeWgsy7twp
         xwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=lp5NoklFUhBFBE1wP/1oN5Uo0bEiAiS4A/6KSQdoOIg=;
        b=BNKEM/KptG9icndbVFeV+HMI1cDoE+EZ6DYq1CJzd8Y3yTy8tonjEtb6vJcrDuyco8
         ZqfdnFLFXa1FXxkzizCRfZ25jeGLgyRNxIR43mmv2LGbBrU0WE/RqcPIUsgpAyNRJoOL
         LZM92qvoVlt38D5H78PPYu/LycXlFd5QjpHDoQojAAbmPFyO0nmJ3cS8CkjPk0bBMgsF
         weKb1X0MZi7A7xVyWwgZoR6fGMbW+xEkWs32nTeLu5TUdEWBU2+udzXqX3ZwVWPkKZkO
         ZVfhht4rriLkhHWYOA7aMQeiqL3JrHAlZ872WXvlXAD/XTDEVIKQ3pJkCBR91Wq7EQq0
         0Ckw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FCy8j6EE;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=FCy8j6EE;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.94 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94245633"
Date: Thu, 5 Apr 2018 14:15:19 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Smith-Denny <osmithde@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: fnic2 Driver Introduction
Message-ID: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942193579895752?=
X-GMAIL-MSGID: =?utf-8?q?1596942193579895752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Cisco is developing a target mode driver for its HBA interface called
fNIC which stands for FCoE NIC. This is a new storage functionality
supported on UCS platforms with VIC adapters. The driver is developed for
the Linux LIO target mode stack. This driver is named fnic2 to distinguish
it from the existing Cisco FCoE driver, which only supports SCSI initiator
mode. We intend to include this driver in the Linux staging tree while we
continue to develop it.


The new driver will include many new features as compared to the existing
fnic driver:

	- Support for SCSI Target Mode (This patch)

	- Multiqueue support

	- NVMe over FC support


We appreciate any comment from the Linux community.

Thank you,

Oliver Smith-Denny
