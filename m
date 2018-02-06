Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517944802; cv=none;
        d=google.com; s=arc-20160816;
        b=uED8w2o9cQZ0GFNTw4YJjIrOssc3moa26K1o06hoFfU/Vxp3NR3EyRdlbkiLFzWSRg
         ms1rGeYG3LskzYwWYlJn+USDryFwLxzqBMSAMuajzhaOsmrY65GHfd8VGoCEAKWnbsQg
         zHhOKGLu8rvQzk4tdPDewyRWD37cCIFgnullN4sJ8rt4l717KJoIZLSU9Y/IYazp65jx
         nR7JugUH3zGcmkVuJsTNI04+kh0NABC2Qzqux9JRLEd2+pZaYHgc5fMH+0W1VpNU15mN
         +Xc7izkakZKNxlYEvwS4SCGZ2hkhMB6PJ4t/1hsLxI1F9jfITy6NeUN4Pu3O3+iikxAB
         g5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=q2lY7ZQSv+esrNgB1jQAYPPlaPDu0Ay2kOsBXvZtPbg=;
        b=ldllCPHs7ZHo3JwTcFGowRsB5+U33+mpLol+poLVp7RoZinKc/Yr6vSF9rGLtijvPd
         B3nk5YtJUzZ6ohGwjKQ2yI6szYKOYJzg7zfko/7X/8lmPan38gmEKuXCTCno/dfHkIae
         IyVTc0BqT/BT18VRtHK2c/F+Nb/h8X2ECEx0f7bjGIn/Tdj2Rw4f89lGKeNSUBfzn10g
         N4EFfFdZb88cDEyIE7rSfyd/i2rcPlajxVoOuLTQHbl2v/KmjeeXotHFeUP5JiUDm6Jt
         UWWsH1fQx4Lwm+NZEH9xOkzDECa6a9rSI0zeW2PbtjYQ1s3vQabZY0pdYe5CPv9eBc5E
         TO2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O2SyUheW;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O2SyUheW;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227EfPj7ERQMdmGfsl7iNIZSdDtCE0KieCZ0hGFjNeIdKg78nJRmhsporhptwyTJvfg3tcEn4A==
Date: Wed, 7 Feb 2018 00:49:55 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v4] Documentation/ABI: update cpuidle sysfs documentation
Message-ID: <20180206191955.GA19222@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591680488853193567?=
X-GMAIL-MSGID: =?utf-8?q?1591680488853193567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update cpuidle documentation using git logs and existing documentation
in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
and tracking changes in the ABI.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v4:
- Fix patch formatting
v3:
- Fix subject line
v2:
- Merge cpuidle_sysfs_switch attributes' description with the previous
  entry.

 Documentation/ABI/testing/sysfs-devices-system-cpu | 77 +++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bfd29bc8d37a..e9ee67f80933 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -108,6 +108,8 @@ Description:	CPU topology files that describe a logical CPU's relationship
 
 What:		/sys/devices/system/cpu/cpuidle/current_driver
 		/sys/devices/system/cpu/cpuidle/current_governer_ro
+		/sys/devices/system/cpu/cpuidle/available_governors
+		/sys/devices/system/cpu/cpuidle/current_governor
 Date:		September 2007
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Discover cpuidle policy and mechanism
@@ -119,13 +121,84 @@ Description:	Discover cpuidle policy and mechanism
 		Idle policy (governor) is differentiated from idle mechanism
 		(driver)
 
-		current_driver: displays current idle mechanism
+		current_driver: (RO) displays current idle mechanism
 
-		current_governor_ro: displays current idle policy
+		current_governor_ro: (RO) displays current idle policy
+
+		With the cpuidle_sysfs_switch boot option enabled (meant for
+		developer testing), the following three attributes are visible
+		instead:
+
+		current_driver: same as described above
+
+		available_governors: (RO) displays a space separated list of
+		available governors
+
+		current_governor: (RW) displays current idle policy. Users can
+		switch the governor at runtime by writing to this file.
 
 		See files in Documentation/cpuidle/ for more information.
 
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
+Date:		September 2007
+KernelVersion:	v2.6.24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		The directory /sys/devices/system/cpu/cpuX/cpuidle contains per
+		logical CPU specific cpuidle information for each online cpu X.
+		The processor idle states which are available for use have the
+		following attributes:
+
+		name: (RO) Name of the idle state (string).
+
+		latency: (RO) The latency to exit out of this idle state (in
+		microseconds).
+
+		power: (RO) The power consumed while in this idle state (in
+		milliwatts).
+
+		time: (RO) The total time spent in this idle state (in microseconds).
+
+		usage: (RO) Number of times this state was entered (a count).
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
+Date:		February 2008
+KernelVersion:	v2.6.25
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) A small description about the idle state (string).
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
+Date:		March 2012
+KernelVersion:	v3.10
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RW) Option to disable this idle state (bool). The behavior and
+		the effect of the disable variable depends on the implementation
+		of a particular governor. In the ladder governor, for example,
+		it is not coherent, i.e. if one is disabling a light state, then
+		all deeper states are disabled as well, but the disable variable
+		does not reflect it. Likewise, if one enables a deep state but a
+		lighter state still is disabled, then this has no effect.
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
+Date:		March 2014
+KernelVersion:	v3.15
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) Display the target residency i.e. the minimum amount of
+		time (in microseconds) this cpu should spend in this idle state
+		to make the transition worth the effort.
+
+
 What:		/sys/devices/system/cpu/cpu#/cpufreq/*
 Date:		pre-git history
 Contact:	linux-pm@vger.kernel.org
-- 
2.16.1
