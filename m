Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeCQTEw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:04:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:6507 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753439AbeCQTEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:04:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,321,1517904000";
   d="gz'50?scan'50,208,50";a="26540499"
Date: Sun, 18 Mar 2018 03:03:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Joel Fernandes <joelaf@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] tracing: Improve design of preemptirq tracepoints
 and its users
Message-ID: <201803180239.bVSVPTE1%fengguang.wu@intel.com>
References: <20180315204401.68282-2-joelaf@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20180315204401.68282-2-joelaf@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5 next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes/Improve-preemptirq-tracepoint-usage/20180317-155535
config: arm-moxart_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/entry-common.o: In function `no_work_pending':
>> (.entry.text+0x64): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/entry-common.o: In function `vector_swi':
   (.entry.text+0xf8): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/entry-armv.o: In function `__dabt_svc':
>> (.entry.text+0xa4): undefined reference to `trace_hardirqs_off'
   (.entry.text+0xb8): undefined reference to `trace_hardirqs_on'
   (.entry.text+0xc0): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__irq_svc':
   (.entry.text+0x12c): undefined reference to `trace_hardirqs_off'
   (.entry.text+0x158): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/entry-armv.o: In function `__und_svc':
   (.entry.text+0x1ec): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__und_svc_finish':
   (.entry.text+0x220): undefined reference to `trace_hardirqs_on'
   (.entry.text+0x228): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__pabt_svc':
   (.entry.text+0x2ac): undefined reference to `trace_hardirqs_off'
   (.entry.text+0x2c0): undefined reference to `trace_hardirqs_on'
   (.entry.text+0x2c8): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__dabt_usr':
   (.entry.text+0x4b4): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__irq_usr':
   (.entry.text+0x51c): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/entry-armv.o: In function `__und_usr':
   (.entry.text+0x594): undefined reference to `trace_hardirqs_off'
   (.entry.text+0x5a8): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/entry-armv.o: In function `__pabt_usr':
   (.entry.text+0x6bc): undefined reference to `trace_hardirqs_off'
   kernel/softirq.o: In function `tasklet_hi_action':
>> softirq.c:(.text+0x144): undefined reference to `trace_hardirqs_off'
>> softirq.c:(.text+0x154): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0x1cc): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x1ec): undefined reference to `trace_hardirqs_on'
   kernel/softirq.o: In function `tasklet_action':
   softirq.c:(.text+0x228): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x240): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0x2b8): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x2d8): undefined reference to `trace_hardirqs_on'
   kernel/softirq.o: In function `run_ksoftirqd':
   softirq.c:(.text+0x40c): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x420): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0x438): undefined reference to `trace_hardirqs_on'
   kernel/softirq.o: In function `do_softirq.part.2':
   softirq.c:(.text+0x460): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x498): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0x4b8): undefined reference to `trace_hardirqs_off'
   kernel/softirq.o: In function `__local_bh_enable_ip':
   softirq.c:(.text+0x520): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x56c): undefined reference to `trace_hardirqs_on'
   kernel/softirq.o: In function `raise_softirq':
   softirq.c:(.text+0x91c): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0x96c): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0x980): undefined reference to `trace_hardirqs_off'
   kernel/softirq.o: In function `__tasklet_schedule':
   softirq.c:(.text+0x9bc): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0xa28): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0xa3c): undefined reference to `trace_hardirqs_off'
   kernel/softirq.o: In function `__tasklet_hi_schedule':
   softirq.c:(.text+0xa68): undefined reference to `trace_hardirqs_off'
   softirq.c:(.text+0xad4): undefined reference to `trace_hardirqs_on'
   softirq.c:(.text+0xae8): undefined reference to `trace_hardirqs_off'
   kernel/softirq.o: In function `__do_softirq':
>> softirq.c:(.softirqentry.text+0x94): undefined reference to `trace_hardirqs_on'
>> softirq.c:(.softirqentry.text+0x16c): undefined reference to `trace_hardirqs_off'
   init/main.o: In function `start_kernel':
>> main.c:(.init.text+0x670): undefined reference to `trace_hardirqs_off'
   main.c:(.init.text+0x884): undefined reference to `trace_hardirqs_off'
>> main.c:(.init.text+0x8dc): undefined reference to `trace_hardirqs_on'
   init/main.o: In function `do_one_initcall':
   main.c:(.init.text+0xb04): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/process.o: In function `arch_cpu_idle':
>> process.c:(.text+0x40): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/reboot.o: In function `machine_halt':
>> reboot.c:(.text+0xa4): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/reboot.o: In function `machine_power_off':
   reboot.c:(.text+0xbc): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/reboot.o: In function `machine_restart':
   reboot.c:(.text+0xf0): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/signal.o: In function `do_work_pending':
>> signal.c:(.text+0x125c): undefined reference to `trace_hardirqs_off'
   signal.c:(.text+0x1274): undefined reference to `trace_hardirqs_off'
>> signal.c:(.text+0x12a0): undefined reference to `trace_hardirqs_on'
   arch/arm/kernel/traps.o: In function `bad_mode':
>> traps.c:(.text+0xa5c): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/kgdb.o: In function `kgdb_notify':
>> kgdb.c:(.text+0x68): undefined reference to `trace_hardirqs_off'
>> kgdb.c:(.text+0x94): undefined reference to `trace_hardirqs_on'
   kgdb.c:(.text+0xa8): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/kgdb.o: In function `kgdb_roundup_cpus':
   kgdb.c:(.text+0x298): undefined reference to `trace_hardirqs_on'
   kgdb.c:(.text+0x2b8): undefined reference to `trace_hardirqs_off'
   arch/arm/kernel/patch.o: In function `patch_text':
>> patch.c:(.text+0x40): undefined reference to `trace_hardirqs_off'
>> patch.c:(.text+0x5c): undefined reference to `trace_hardirqs_on'
   patch.c:(.text+0x70): undefined reference to `trace_hardirqs_off'
   arch/arm/mm/fault.o: In function `do_page_fault':
>> fault.c:(.text+0x2f0): undefined reference to `trace_hardirqs_on'
   arch/arm/mm/fault-armv.o: In function `check_writebuffer_bugs':
>> fault-armv.c:(.init.text+0x9c): undefined reference to `trace_hardirqs_off'
>> fault-armv.c:(.init.text+0xc4): undefined reference to `trace_hardirqs_on'
   arch/arm/mm/alignment.o: In function `do_alignment':

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICE1jrVoAAy5jb25maWcAlFxdj9s2s77vrxBS4KDvRdv9StrgYC8oirJZS6JCUrZ3bwRn
10mNeu19bW/b/PszQ0kWKZFuT4EiK86In/PxzAzl77/7PiJvp/3L6rR5Wm2336Kv6936sDqt
n6Mvm+36f6NERIXQEUu4/gmYs83u7e+fV4eX6O6n6w8/Xf14eLqLZuvDbr2N6H73ZfP1Dd7e
7Hffff8dFUXKJzWR+f0366GeElWrSU2nhBc9JeeTqQbanNUl5X27egDuqiyF1KomZV6zvMqI
5sJ6t3lLClrTsrJe1YTOtCSUdT30tEzQWcLKMaHh5/JTmpGJGtPlQrG8XtLphCRJTbKJkFxP
rSWmfFkzIrMHeK5zZlEmrGCS03q6YLjYMYGSjMeSaFYnLCMPPUPBWFInOalzUuKyNLO3lE77
HapgG2Km3B0viQaecgpbOefSM3BcTfrGcqJJnLE6Y3OWqfubrh32pF4IOes544pnieY5q9my
eUc1ewWn/300MaK0jY7r09trLw+xFDNW1LA5Ki/7vnjBdc2KOUwYTofnXN/fnoemUihVU5GX
PGP3795B7x2laas1UzraHKPd/oQDWsdMsjmTCuXFfs8m1KTSwvOyEasZkwXL6skjLwcC11Ky
x5z4KcvH0BsiRLjrCe7A54lbo9pTHtKXj5eoMIPL5DvPdiQsJVUGOiqULkgO5/DDbr9b/8fa
VbUgpedN0OE5L6mj1NiA/1Kd2csrhQL9yT9VrGKenhpBAK0S8qEmGhR8ar9dKQYa5F0aqcCE
hQ7Z6JDhwBmRLOtkGGQ+Or59Pn47ntYvvQx3eoMqYRRurFJIUlOxCFMaBbMlQSZAA5uzqCVT
rEgs7YB3EpE7FnNKigQkv2lGDpc9FZKC1dBTyUjCC0vBVUmkYu0b5w2yp5cwsAip8myX2SmK
1lOJCgaoE6KJx5IhByyv0KrbSr15WR+Ovt3UnM7AHjDYFMs2FaKePqJ+58bUn+cJjSWMIRJO
PfNr3uKwMYOenC7A/OIW12i7pLNMM1XwIj/r1fGP6ARzjla75+h4Wp2O0erpaf+2O212XweT
hxdqQqmoCt3s9HkotLcDMm6SV0Rx54017Xm9fLFKjLdjoArAqr1MmqgZeorx6iStIjU+hVIy
lpe6BrK9AHgE6w477lMe1TCfXSdjwyacRe00YYcwsSzrz9aiGE+n2ITGGVeWNBhXU8e8uLHM
CJ81f4xbzP7Y3h57SEHteKrvr3/p18wLPasVSdmQ53Yo0opOYWpGsO39oRMpqlJ5zwCtJCgb
HJSX3PSIzsf04ed5UKkCfYTToeD2Ey+TRLTgF5VsBi/PjXeVic+g0lqUIHT8kaHFQNWCf3JS
UOascsCm4A+/oW/seWctCvCuvBCJjUiMxa14cv3BOt4y7R8aceufB7yA/zQHSy/tCaoJ0zkI
W90acP/kYCt7A+/MedyeNvbVwkXGNTUmw2o1IjR8rouc28Lr2ASWpSD7kvlPjIBpTivvCtJK
s6U1Q3ysS2sgVorMcaeKTwqSpX6xMUsJ0IztTn0So6YNqO09K/eBJ5LMOayk3VZrw+DtmEjJ
3fMDVaCzUsDeoWHWg93p4An29JBbnXUtNXHX3bfHSmSwTyjYYIYvdNrsPKqS5nNH+EE4fWJl
ow5poJF3v2C5LElYMlAAVLT67CE74cFG6K6e5zCYsWA9MqLXV3cjY97GXuX68GV/eFntntYR
+3O9A2dFwG1RdFfgdRuvZo3RDOxdzTxvqLXxQQP32AtWVsUNTPCSEZYTDVh/FnibxD7Rgk4d
6c2En43EIEZywjpM6r4E1BRcETqQWoISizw4iZ4R0RdYer82wOlriPoQ69QQNPCUUxOCepnB
9aQ8Gzhv++hFw+HI2G9VXtYwIRYQsSas89JMnx/uYoifIH6cFOhTKIKDEHxDAUN/CgADsARA
9mE0Mowhm1bJtJcAjsHb7pjAHmabAHsqxGxAxPAWnjWfVKKy+jr7X9ggxHUtovXgaiSiAQT8
oCtrUWZYk3Vguo0dvBMz/QI2kRXV9WLKNXMxiGGVbAJWpUia7EK70zUph2ulmW+BwNdojc8a
YNe+drQv7XBJlQ9Py8y9F5/BshcENBlDrQbzd6GwpwvFKGptDZKpjW22OSYAAMqsmvBCOTFD
3xwSduAwUwcR0YyCYR/ACpcIWL3w+8UxK2xXlRH5L7nhWIVXJcesiMgsCDsFNcEdAq8wPB6U
V7bURqZnToxlyAHwP+DywP4BRy6S9oxKRtH4WN5UJFUGkQzqNOIKOZIAFHxDMZYQcJvv8HNM
LMkCEbYeLpItwbIMlW78Vp1DcPrrJTpZ3l9/CDPAy65N66Y/9UdLioAVM6rnO9UMBAlcOp0t
wLBbSxIQRgAqUhXsZZHcjgiEurlFPD4IIFkK287RLaapowL9TOdtco7OQoYXIbQAPNblWeRi
6QCpAE/n5ULdGtOmwQTqQMcj4r/oqRGstqchj0klaoEmzQrfWGrk16DXcxKQivmPn1fH9XP0
RwNVXg/7L5ttE0NbhkTM2/ldmptha71n7aD1xkq1nqBxJVMm4bys+cGiEDHbWmwwn0KwdX/d
z6ZVKs9M4mH4l8UJSS+GXrEKRPE9PZSz6qM3zSaS68sx3qMIwRfkoHkCmIQ1fsBvNJFtEfvE
rBkC3FbtCj+2K8AboiTZCJqWq8Npg7WASH97XbsYlEjNtUm9JnOMNX3AOVeJUD2rFeWk3Glu
MnUiUk+/r5/ftg3e7ayEaKLsQggnjdq1J2DVcF8843csNLUya10StGk8d9c14zAXUqdtl/fv
nr789915nZ9Gs7Hse0+cPcRuzNQR4vSTZ8yq4IU5cVWCA6uKVnJtlerrKho8A61lvrD7R2z8
6MqK2WplMkfmVPuNzvNq6B0wTi8hnMKEwsjOsViR6+srf67WMJQfb5fLMD0VQseSJxM/XjA8
BdMXeuCivL44BDDc3vwD/fYSfVneXeo/EfMLk5+pXz98fB+mLz5eLT9eXdjBrKQw/Qvjl0t/
DcEQZUnDRHN2F4ZWt/Tm8tLJnBeUhxkEeNPrkejlb9vT5nW7jl63qxNGvEDarp/aimOXvIW4
97COvqxeNttvDsNIPOv53UgyO4I/r2qzvPeondMFsIS6//CPvf/yTxwGWQ5KVy7fhAEo88Gj
phexJHaeLScYHNJfrq9vsjEwyZcX5KEAI+OmbBoXcNg/rY/H/WFgLHDmKXl/88HFWbc3f965
LSQGr83mg9bSNGcMwNqDS6GwBMTdc+1rT8mgVZQPo0adxWPG8vr9uMW1ediKKLypx5zLHv0W
pOvV6e3gOsJGDRFNkSSRtW7ieH9IA/3zZh0JYN84C8RJwJb8v9gWgCwY4HtRTfxIG3njUrIE
caGn05bNpO5nJlidsqx0sqTD5r5vM4XsZnnlldK8zq5bniYv/96mmYo4yzFtnzKJ0xpkiU1s
1eRxZXcg8RsWoV5f94eTA0kCxgjauyPt8GWQz5MkbIZYPa8xMwc86+hpvzsd9tttUwzr5mH4
kvVx83W3WB0Ma2PFlMuC7Wz3/Lrf7IbTryGeMRnUwPwocSsAdv7Qks2Wf56rMoPA79YtZ51b
MVAJ5A8blhs/7O3I175YvCQTVguIsJi+v/qbXjX/OUarkPWk5OL+yk64NZWrYO6gY5iLDOIT
Ih98Qzc8diK/ecnENFag8Yg3PADDXVkt4AsHJcqbgHdE0vsg6Tb81vswCUb3ac/08R4ow3LT
VGLF0qdsjMTcXoWA5zaRe8HRm3gCldATpA5YWcZol4DDGMsb6/XxdJkW9ZxkPBmWbqEHX8QP
VkotunJ4SYoBHDWZMKPBEFxPqwkDQ2/VUgCnOpd1sKHGypWxMPkoSYplDBdSF6KOAZMOqiOG
uW2HQC4VplNfVtuoRamxU1yMuv9o/juvD09ikJzI+UR2d6F6af9X7mSmfJvYBSomMZNj4gv6
ub+7+vhhCD5hN1Wtp2XozofxBmDtzbnMnC2hGYOYD426390EbrY8lkL4s+OPceUPfB9VU0fx
zK/LFZirWoDkJWvOuI+uTDoZDVKX3fPbFlNXqkel9j61UZV1zAo6zYn06Z25p4HJMRPAC5mA
q7q+PosuZvRzzDvBLJz5VW3qecH1FKWRlv70QJvX9UncggtHCbgARNN6aUeiiCSYy/RvQEu8
dHWhcbx7eNq/IhS3/AxCJpE6aFOTiS/38ohaVEuR15hz7e1v3x4rdX9lAwRSYpIPA2vtFJYM
DYbBdo+JOwtiE4zb98ZmbMn8AIBKoqYmQe8zrgDT60csLqI+2bXglI82CiOYcv/X+hDlq93q
6/plvTvZ0U16WP/3DQAFxDZPq2EmzUBryT55e+XP2/WQGeX8UgTNEnXmQ2dYZmwMI9LtfoX3
YiIDTKL1y9t2ZQdl5BRt16sjnP9u3VOjlzdo+rxuY7T1c8deHQEdva4AMn3e7FaHb5Epbp4s
sYnBlOYaE9tOPurcWqdJyX16DzSsvVspwOYdRSUvtaczdAThuhsRlZ/avp1z5ZsFTqGt5TSw
zhz3y/m4LT3pFc1fxnTuxHoN8flGZrE+/bU//IHnNNJD8C0zpl2txxYA/MQH1aqCOzEiPo94
z1Sd+Y3jMgVNrEIJSZg6KJwPrfFmVd1T2cB9SpSzAmjv8otgHyrtDtMzlUXpdAbPdTKl5aAv
bEZb47+p0zJIIv10XAwv+SXiRGJFO6/8eZOGp9ZVUQSqxLgPZp2BInYBcidmPFBHxv6r5OIA
yJKKyj84EkmgVoM0pgIb1yxs6KRcuhGUS0tHpn+im04QeKIzLRTmPv8V87/uNmbsQo9h7aAl
lhInl7LhZx5axXYBsENsHf3+3dPb583TO7f3PHmvuH9wXgZyUTBlvO6NAGIIXRyBKDWMnBGl
eOpHIF1HAEwNSACslJchPAXMTQU6JOEJpUEFVDSgnDLxy7zmoSyn9lvb7CYwwjgVbbsJc/yK
2AalbfIHyRkp6l+vbq4/eckJo0VA0LKM3gQWRDL/GS5v/EnmjJT+slQ5FaHhOWMM5/3+Ligu
Jgz1L4v6x0sKhZfCBN7X9+89nBYxtSQvWQAInAPY1dRvneYKLysH4DtMGUDgLKy8eRnwbbjY
IlC8nqqwx2tmmjD/YpAju4V4QYGO1Je4Cqp8qV8kySWWzh/q9rpgt42fsgFSiE7r42kAMI3K
z3ToEvOU5JIk3J+UpsT/UhxIG6Qw02AdIq1nNHCzS0tG8kulzgUHLD64ImURIRrzm5F0xgOX
AHFbPvpNAyXcXyKmrJzWoeJvkQYSjQqsZwCyG0+a+mnZ4oIfS5SuwxH5RAqYa3ZBzkEOUUs8
4paThyYt3nAM75bg3crf+BmhJus/N4D6k8Pmz6aM239JtHlqmyMxiiGbC4vnwNXXjB9BTe/f
/XyEiOLn3/en1+3b13e9E53rvEyV7VabFvDrTvoPfFeRELxc4kBl2QyVcpkviGyu1/mNXLqo
M0ESLxTFXMXC1PKt+MCy+liATyQPmcGWgc1lAOE1DPipVNsNmNU8VIPED++mD7Bzc66Ef8Dz
1x5YTGBzTr13JmwujIMHH8xINnGya81znedcOKvPSa2msLdJm+4f5xfejtGzkR8nbIolzRWE
+ROuYohp/co2Z0s4Q/ONGT77tVWA+uAFMZ+UaydLCY+wjsQkJvCmgv84kMu6lnGBi6RqzGHR
RdqQh3Mg8pfxe4PLGa+rw9HSNQy9o3yP9yiaO8T6sNod23g9W31zblfgGHE2g7O3L3ibxsE9
mVQHzGaIwIMUmSbB7pRKE7/ZVHnwJbODIvANBxLPl01A+BrHO9pPSfKfpch/Trer4+/R0++b
1+j5bMTs80758JB+Y4DnjFIEThcUaPiVWdsVQp72xpgaEwvRXu51JQ4oMVioB81GudsRYxZg
HLBNmMiZtq/VIgXVOCaAnRY80dP6+iL15iL1briKAf3X4CqGk/DHOh7O25sLC+bX4+3mN76t
5n4kfCaHZz5INAxfLDQgmKX2jUly8Od+99OxgB8jF3qvNM9GBo340ZahBe7YGyMUK/CNI43J
V6+vmIlq1QRTfI3erJ6wYD5QG4GYZ4lnhJHjQNix4pGPJb1tDid4bSY3B+1SzLVpAlvi95QD
5vGlC4cTq5emrBLuKyP60mZn5nPuYRfN1az19suPWGFebXbr5wi4W5doWSOnL5VdGqmcXqLC
/5fIxgfc5HqcLU42xz9+FLsfKR73CPI5nSSCTm6DQxQAxsL6U7Ah3fSelbhz/9P8exOVEES8
rF/2h2+hPWpeCJ6G6aYu5uGdUCUa43AXVewL1BJtpXlc8QQpqwquAx+9AxWT1vg5pt1BW+ry
kmYi/s1pQOkCPOS0OZ8Yw7OTg4XnPOHCacCvmOUcnaZbEwUSoE45+GixA8HmspH9axDof9sf
YegRd9Pkeb+9Dju8poqouqiyDB/8MWjLRAGCN1+mXmTLBjc9RwyJjMO3cc1s/oEe0i2aYK0L
QnCazP094GdKuME10/70w3mIeKweIMjMunXSIzVorwMxqaFpIifMY+c3xycfLgenAHGFgvhX
3Wbzq5tATqjK8weUPC+VFTQTqoKACwVtGH/0QwXNFFe0Bnjsj/bpzVDEzPwZK9Hdee4QNZT6
4y1dfhi9ptd/r44R3x1Ph7cX84Xe8ffVAYz0CQE2dhVtwWhHz7Bfm1f80+5ao8se9Um2p/Vh
FaXlhERfNoeXv/Dq0PP+r912v3qOXgyKj37AcuHmAHCe39D/dDif707rbZRzCpbwsN6an3wZ
XEfqWTC0agx0R1OUp57mOSjFuLXvaLo/noJEujo8+4YJ8u9fz5fr1AlWYNVLox+oUPl/hpkE
nN+5u/7c6DSQr1pm5hOBIJGkVRdKhwIIZAvleIRvgHbhineuuz+WTp6BiAUH28ZJwhP8RYzQ
95qDZKBDwOA6TGwzoCFL41csXwkDOmqzBNalGabrth7bWydRJKHygLEHflvwqSIZf7xQStQs
ZAYIxYy7PzOwDFHgLcW8v0HBNPylhPMbFOe2OnkoSG6XcIDmJmJNilWYX0gotIQ/3OsYuvJP
CNrrudlQ8yspAbQ6DzmFIhv4vEZFMHnZm6hnV58AyZ0Om89vaD3UX5vT0+8ROQCKP62f8D7h
OAaGwfErH+0uds6KBD+8ywjFy6juj7oQrAaRWiv/pdP+7Zw82pejbBLIRqH5qP7SkWXArVks
lRTSL+tmx0kCviiclG17iaUgCQ3EShYf5VJWvmSPzQO+iRfOkprI47zHfgXKP14FrhImg3fG
Y7JHOnV/jqhpqYsSv+8rCMwA86AsNLrVV0okSbwI0GKacsUzTge/AMOX76fJTT0BDfSOgm/V
KQuTy6u7IDaaFoHPrAuF9Tp/Jh+Jw0V7VlORBeMBITQB/T9tWk4AT1+oQHRsnErv7UqbZ3D7
n5giNrY1AhSYZkFAEfNQYaljYvi1rcgdsw69em/iWe/9X2NP0tw2zuxfUc0pU/UmY8trDjlQ
XCTE3EyQWnxhObbiqCa2XLJd38y/f90AuIHdUKYmcYxugiCWRu+NJBx57/5jt9BQs2tZJEdn
vYCFkZ4kCUOBlr+CBEkvkdUwmY9cz2chu3H6z4YhFZLVx8hirwBRbHjz9RES0nFo0IWPKsmh
CqgPL3Eb0IxND20peLJmUFbi7ugsy00KHNBmoIIOVn69ju1j2rIIIjNWg542Bxtn1VCRrdr8
BEVebhtoHFHOPIZvaDquk2qtVDDHsdACUYSO7mgy08ewz1i+2AAr2LMmraCl/60xZuwqxHyO
BqvFgDhqYUqICbbzSh0vCewnO5i5BnmE8vrkbM2CYRGu1msn/PrKBTfXH4vgC7hI+eGZK4+F
Y1CZq/sgvz67nk7d8PNrN/zyyoYbqAoLqK0FFX4eV5LtURH9er3yNixKLPFGPz05PfV5nHXJ
wsyVcRR+ejLncdR94gRnig9wYuC9wWKknol75xBuqcebWyBEJvHGnnxD+dkukfo7h41EmAeW
4enJmlYCIccKxFH4/MuXwOhKGbLwNeaQAVoFR35a4N8kVp4zecPioaehIhEoff/1tnvcTio5
a8RKhbXdPmLKVxCkEdJ4f3iP96/v2wOl6lhZUpHWjLzcf/+1nax26D/xaext+ufkfQ/Y28n7
zwaLoGArRt7S4qMUNPcsZDAekHh5/XhnxWiR5lXfixR/RQo8uH10axShDpP1GNFIKLJxDjka
Q0fL3CSM1U0jJR7cAGsbqTXO/sJ8hDtM6/Tj3lKpmeezSobucXzLNhbCABwutQLVatRpa3oT
O1LdDx64CTezzCsGWoqmDW6aG0b92aLEN0dR2It8gKEWhvE5axH1rLtx0nBVMmrhFgedzVCh
QW+UFs1wl0eQymzlrZjUfh1WlR6dKIympg2RLcr6+IrMGH+r3r5zbzppx55ZKCqJMOdBqxCy
yl9IuIy4FJp6JJbTfU9aEOej1HuaNN4fHpX2VPydTZBMWLrqgtlocy8JSS2x//P+cP+A1LPT
fTeXQzm4pZYUZ43u9F+AEymHHLWOeVbNNNmHgcIdmmapdlQq6BVN67mkl9Kky6Z9uYAqWJYc
aLmxwvGMHfKwu/81Vv+Y8TX5sXucsAZcTy9OyMZeCsyew4P93QozQqaKGn4fybcVdIN39dPa
9AFpUVfKz+aUghYY+JSELhSQ1lRAEjf2xEvRK5PzBeqjejLHELslvu3Ixyq/KTvf73ByMfUV
a2YZfKSk/AYG8y9j9j2ro/2HjEtnfwjl9PqaymFkkNAbqks7oo1a+5e/8FnAVhtTMT4EW2Pt
T6UUQb4Tc167xoWLEIuSjOvUGMOgo15jbyvavUrfTxkG02AARb7kUpgYFKM+/VZ6c3urMKjH
0AxnmsujmJxi1YBhp9RxfqwTH5UcGLwbiDmIdzFjSG/mrIST4XyrSrpUMfEA5cZkcKXVfEsf
4w/oqycH8cTkGqAfXrmyURZnXy7pG7rwVi6vz9KHP0xsGKxUvLG+VfNvU5/a/thMzlzOGI/y
hAYsGGtTnhOuiGU+efi1f/iHTMtQ5vXpxfW1TrzMSRxar6IydbPBJj3R4/7xUfk+AiFQL377
PHilSP2ycOQhw8R/FfBmieYuF92xxt8HCh50B8r7XhEGA0mtrUrX3rksS6vepXIYEyNTQONo
29C8RDu1PN+/voJsp/olpC315NX5Wuu7+Ddr2sDDg5UVLtIHRiX+ODkdZEnoj7kl2PwL5oV7
apLZ9aW8okmhRoANxGTZ1vDcv14ztLSZfJ9h/xVc00Uefhcuhx+glykK9OJs/32FDWwtz6L0
65D98NUpfcqyVVjU3pLaKRqGnjlDf5quWXlM32Qpvdg2oiypVe9jmQNA9qDmBRM+c3dAHzku
/emXCzq8qY/3u/25vfr6mI6VH6PppiyiLUUGpwiVc3hC54LQnWJ6tngznjrd7si+nKMOFVEZ
3ZQsHeCZV8JJh+7l9OqaNhQOUOgt2KDMbqdX3KHyF+gxhEat9fWXE9rLr8Fhj0CDAJvj7PKC
HsxixXlzoaEr8Shav0InyyDrpWJtWixWrm1OQVjfZH2NUgsypTrUkocpCrkDCaDFG5F3RQpW
9+8PPx/3Tw5XSZlFZdsNT4GcGIatc+IYO7cbKSpXQQnE3o0VrNxw2BXI2pJIDYo2V8LbBvai
EPj26Sk281OZH7ZY3GP/8T6Z72E2X/a2EtIsCUidyEbAutbzjFKZSTnD0gBSzCweXlKEERh2
j0SfWWlPunR3Pz5eVP46lydvFPAVBRCIyW2A347DNed90GEtYp+JoVCvKTJZMykwVB9S+IzD
LkAX4vIcliZH9y3ypJbo7ens4iZMcia2CsFJeXn2hU6dh+A8Ye94BMvk4oSmId5sfXFyMprl
/rOKsg92IrSW6I5/dnaxrksJp4efuJJjvxTwKr68XNNOZAruX55dXx1B+HLGIOhM2iUjWBW+
Y2+FgfCaPKKj7Ts/3L/+3D2Q+dZEsgaRqVqe8Z0HxVix5Pn55JP38bjbT/x9m1vvz1HxOY2c
BJN49/2AGUQOcNR3L0N9uc8mlw4w8xyw6WOBTac7Odw/byffP3782B4MVR50HDH5fD3/Jlae
zXDEqFnrdIJzT5V5o1mIrCLc2hciGJs4Fnb2rKC9mTFINp1zTjAiALGTBFX4ovEJwK4tAUS+
bh9Q2YIPEEQLn/DO0duLG0Lt+QWTDENBcy4OVkElI+MrYIUmQxY8C+MbwcQ3A9gHrqGgtfIa
jB5LDrg6NTx4o0IRWTiszDxLC8Eo2xElTGTN8J8KHIfcNaDAd1bSlQF0HiYzweiVFTxipDgE
QsdKhc8jbPivWoEMyjjdqxdvCr4oByKgcwHfu2BOG8K+eTNG9kVouRLpgjFa6o9OpYCj5hha
7PMMuYIz5isNS7MlfXUocDYXzkOWeHPh88YbjbKJYo5WKgRl3wcmlMfIsJiMY1+pDD7uzZGW
jLYJYEBJQ0ZpJzCCM0VWP84cGzcPSy/eMAK8QkDto+/oIPbQXTcVPn9484JNLoBg6QnXZ7is
hgqOJgHWWVthlGEYoyKUKyYjlEERnVZYeMEp/fAQomkOGDj+tMgEePZv2cb5ilI4djQQARk6
DgRW7JjzNKhcFJUsx3G8A6QK7786lzQfqqiREEnmoBlrkSb8N9yFReacgbtNALefg2To+Jl6
UdG8hrrl4pxSAVUgsWQLXwCHU5YgloYpXEc9WxzCR3VvKxU9b+owLPwBW1ENRR3tqgBtlMc4
tuc//3vDesM6npziDfBtrKdQliv42g8F7eSAUCXvLjk9P2JUMaPVVo97wZyxRJebnJF/8MHG
g8/5Wtb+UK0ooTFJetEC+aqQ4S1c8USjFBgm23OnTPzaylLaNmF6z6wYVF2R6LPImmPwSTvi
UEupif+3DP7Gp3WAj9+mOCbDOqGfke6qB5PBol8Aum0C+lpGA+tzB8KIxcKTXKTGAK/8Qkt4
HZbLm7/DivDnGZV5F3Fa18/hd9M8NYIq6E1cFllM69wQxb9dMFmq1RsZo1U34jVwCkdniHNO
SoCpZFIHp+Gq8ZsyLbHKGolJwSzvVtNa8+yEQpoVKCalmJFjsUI5LZ0TWSeRKyKIh+4BLaNT
Orq+Q7i4Jj5HgW2ttWqMy7OLL2eOcSgXuu+/di//fDr9U9G6Yj6bGO7tA7X7lFQ0+dRdW3+O
vsShfFZwO31iO6TysHt6GrhfKHzjX2yvVuN2rKpCMrCuSO9wCA3cCvamUBYhHItZ6PGdtFIy
/8kNqlXRkUbCpMlLrnjOANNWMlM4Tb69rvLM7vUdjZBvk3c9391Sp9v3HzsM0cSk7z92T5NP
uCzv94en7ft4ndsFwNyEwkqZwHy/l3BGuQEesL+CvrIGaNrDklZ/qWTDYiZibiYF/J2KmRVx
b4AhMDNNlRkJQn3PRKpAI3ajKP16YEnFhoag9JoWfpnpqINxYxNd8Mfh/eHkjz4C1nMEDmj4
lGm0nurUYCV/bSEsNb5ROh1M6Q99NHuIIi0jrekfvl+1D+sWt81WQHu/va5EqBLA0so7HHWx
pC9uNPfjSC0WDa39TDNa2Jmn8qYiyxA2GgmImjTv0yAE8nR6Tadp6aFcnNK3eB/lgubeeyiX
1xd15CUiZhzEO8yrc9rw2KFMz08YBw6DIsub06vSo++kBik5vy6PfD2inNE5G/soF1/cKDK5
nB75qNnt+fWJG6XIL3xGZd6gLM9OpjRT02DcbdLbZOzuvH/5Cyn8kQ0VlfCvE6aUVDv3KWkN
bydjxK2133d1djKuQ4SXt9y+YOT5cHTm6SDxulDnts+udUxJdDht4vXUyd1TIKLNB2XBsA2T
rlfoHwXcURr2Sywj1Mqprj27EjnnQr3RFyvkgDpMRQB46KPUsIbaDqfdJjs5bZZH3poPLleB
fQuhirjME/q263BIcLDC3n1yHv1fO8yyMIiNkpsUZJg1OyRoJwkltM+qiErKrXqMOB8Cr1oH
QuZcdfaKsfiodPra5YvatAhGf5UwrQZ+xKY5oZxMdg+H/dv+x/tk8d/r9vDXcvL0sQVJjTDM
6Jx/aK3C4gfk+GTpzbkA/XkWB5FgeHt/UWRJ2Dr7MBnXwjj20mxN+gQ1Hamkc5iE5aayK3MA
DK22ude30uuMLqYqr/7c/fPz/gW2CXqeKYMORqsMzEPQ0UIGtFSFwNusELTHbPe6mvPg7KFw
ddj6KMI/ownxYoUF/kjvOP1tcv9xeCBC8RWjr+nEoMVKNQdvl4Xf5GNsqEVZJgWa+Btpodvy
mKdb9SPza+ZC1HbmnKlMIhemA58hCi1CUlb0nLQYZUILCGE7SEalnHginmW0olaXyeCMnsX2
ef++xcwk5KUVotIQubzxg6/Pb0/kMznQbXO86c9Fg+CKKsAm4T2fTL3GDDb7z93rn5M3lEB/
tPlUWw7Oe/61f4JmuR8xd7PD/v7xYf9swXoj8ClvMC0ffU7WVJ+3H/e/oEu+zyqF24PN3YOv
LMfFM9ZYW/Zfrk/j47L06W2RYxmjpV0+o9s165KTxHVVI3q7MKuWr8aGZfTAV0nwxsFqrcNo
76DNQZzCyjFp0S9f20CWZ7UgU4aa1AtwiuFi9y23TIF1H1gFpXZ0g19MXhKal0jGuxu1ufLj
+5vaiwMH1MYDlA8qrtEbEZWnfOguuvsCGa2n12mC3sdM7uQ+FvZHY6EpzufUYEyS8sIbO255
L4+H/e5xwIKkQZEJJteVRwU1pHbMjWRS02smjTHoqxRRNN/HuHYLhvrJWCSUS3nU5J8iVL5t
XmT4FE6/GK1qPyJc4HqcRTaPw7av0QDK7dPhvpcGa5A1Ktr92k705utdgZFEYj7MHAmHfFqT
TtYAObMKIJsm9OgS69rzaSG8wZKhX9llnDuU87qvEVANmDg7wrwrMCbrtee/9dpz7rVDpDD1
i03OGs8VDqf7+DYLBmPD31lkTKg9U4nGh3HaQoYFwJiV/8aDMj+S9nJ1pKN0dJqK2PFoNOWf
5Ca+nS3kC+x9otuM6SUj7XKqqjnCRdpzO00wjq/EknkWvD8eegFbeJqVIupl5w3sBqEblC55
0LWnAbRwVmVM+i8F8Zl0y5gDPJLn7OyqTc+sts4aWRNOsv79w0/LCUuOMtprcPAXZmrG5IlI
FTqi0FFSmX25vDzhRlEFETWCIJN/R175d1py/eqK5kyvS3iW3avlaDfqS/Vt+/G4B5rXf11z
iwGPOaAoqgGNCWVsNaoqdyBpCNhmA3dzBALXEQdFSG2sm7BI+2+wlJpNSv22P51R3020NM4a
M9nR4o6u3FjbwmkrMuEPNVu9I4RpHvH0oIo3TAZjygq0LfGH3QscsIiHhepActAF/yCAVMoQ
jqY5xjpzDGcEammrpoLdbDUtmoh3BfXadlUwWCfhHxD+Fg4wDK7g6IZGlBWwAgzL3HbF7wON
gqmd0VkOCF8TFsx+4522J1g9xHeUyUfDCpQRx48U1YxxDvRBWGEWQN5WnlxwZ3/NrxymdFuz
BDFxbKSch92m63Mn9JKHFq6X5rLk3Hnh8C1Zksptzyacjzm9qeN+jyTNZquqK8xDvuAAWeDx
ZIAfBFMzJYjHsp8pxfzz/uEfXXJHtb4edi/v/yjDy+Pz9o2q3KfiVWuzVzs6qJJNxsgzL8O4
sVt+vWqJIhwbpPsjjPMeQVEFLHT/QcipMU1CS0an7e+fX+F++gvDLUC23T7886a+5kG3Hyit
qg6FxGq5NDFTITQ1SAFpLy+ACzWpsMDNIiTdFyI4tbq3r6cn097ny7LAEoIygb3LKCuLECRp
fIPHJFSoUszGgh3MMmYz6KrXq5SsCaOnok+fFyGWj5H6c8YBpMDtIx3ESy/xrJJXzXdZKHom
s3QYbGberMrTrkLvpqnmy+jLUOMAJ7SgEt/prpBdCNsSUyY8Ndh+/3h60hu+Px8qU4IcVDvW
vSBUFfUdj7UFNctO1KTuvyPPgNNLLW56CMGqztJLOenJQkavPvbzs9k3mHc5HrYBYIHsyDY/
MKhRETIxEwM0peN01QJqEJHG/gZa4Vdq+/0GqqmLrKoBOzZ2gz5csL42S8bVbFxeuTkLqPA3
u0slaPJu7P1yrN2kxY8x/E7chV/P+zXTLdTW+WPoXD88fyXqzyqkreOlXlLGjNat0uBoux7x
sAawbzaV1YFfKO2PlQud/UMLKnjkJvH+4Z+PV02LF/cvT6N4wljFS5vcIGTVI5M2ZFHB1i89
OZhiPVEtqDZBdF9PpyfD+wXrRyc9xNz2VTmGi0Xiq/Brr9vVrTu0UD+GLCMtiA/gbfcDYPM5
vbeqwoaOqFwNZy81BebLiOun9eYK02B8mVmbBQd4E4ZsnU1DMYGOJPnYiIGboyPNk09vr7sX
lSnh/ybPH+/bf7fwj+37w+fPn//sGapVl0UJt20ZrvtZvs0mNHYqu71Dt0a3WmkY0IBshfXb
2K2vtCrNrdBJr0tCn4INwDQM3M/waZx6x0yZxxwYjXtTHDrRzIBqLxctxaeXXA0LTl6JBQ7Y
i6GbJOL6aIRqldUJSEAUe/3iOWo7KeAwHBm4AZhM4F3Qzx6LJ/N5SwyF1HScXR/4AwLhLJME
TYyF88rLxTEM6drhSn8l3LegX8BXYmLUIYOmrXJ+RfIoanMBcKDfOLZWeH/CxRi5Mbhueih4
tcLiwRo1hGh6anWCq8q+IrwlXFDs03drmL+CZ/vM6qqdChybKptIC0JmGeqwKFSy62+aB6VV
gOrucOPEwPKn/sYKCOuzBVGVajZXTUXPpXUInRceyIMkTiPYRM0R4YH1SpQLDKSV9ns0OFGM
ECD4mcqI2EdBnZxaSsQEZjIt7U5886DupadhgyeQlozcJ6PRobZmg7r19F0AVMIaSacXLW6B
MYiILnoqQ9WJC0XfZA6ExQoW14UwZBYNJqNNNgnt9BQzSZ/U87VMvRy9myneAwgg8Ghw6JUO
Ph2V/9TtXgrbXKWo0w8wMVYtOlYjciHq294xEU0dH5E5zrvy56hVgVLH96vVrmdwphZ2tW9r
s+merLxG6MWFN5rWGXYOrCYlHpIyfNb2WYpvAsaaqbKUIOEHXpQJSFEoLHTWXG3qYnRQ3BlW
w+LhaFYtgAes3Wj69r88d0txasiLcI21XR3fVBY4WbpwLbNmiHcDiCVjptVZXlB1Q8cBK/hM
lJw5VsGrijFVK2iB4fMqZafjW7kwj0gAEwvvp7ecNR/KaOEYJq+bApmIXQwlf6Z1gOWygLoW
FW8B1TWXWQlUSXA386Dnr25+a3vA32ue11Pgm4D2LVDdrzw8ddVMeikqJbCWGa1wmllhUGMp
Ez0KaiF1vWErGSVsPb80OMxgkjovcQPzmRt6OIogMNpRw2dQXg/YQ5WuYJOMGUY74GXITRKC
s/BDLmtfozPTKR4tYcnqWIXGNSlKbSbWQPP45JT6nhZLpH4M+/XrH4/IVP6NvX2Wf4w+sXkT
25V+22Ijv578++V6eoL/ERioMwCMHwaFwDAZQkUEPCQ7DFQQubQ+HWLuxQk6Kv0WchSrYnvK
mcj1QNrYeYjp6ID23H68oI75sH17+/yzDf/Q2h6t0+4vo8rZbEcdmVy2Dx+H3ft/Y837TTjM
zovUGm4srIADIKThjJ3OPMswN8pyGAY8CgDqYIGppnXGAy5ZrHb7gLs5lMpzS51tJ64TSBpo
FP1beAUIUDBkPJp+lm+0LO5Z9uQRGsf1lMJXOJgeTd+C5DnQ7F/3nZ7/daSBaqBf/2i3gJrf
rPUDPvz3+r6fPOwP28n+MPm5/fWq3IYGyPA9c2BvevaVfvN03B56Adk4RgUezhf5IizGILw8
ycYxatFXcXRtJGKrZR0NkB3JTZ4TH4kHb+D707xDMv7MGhwwzuEaGvoBpecxUF1kqhiNxbRT
o2Gui+GDdSCkEirUFU30Mo9Op9dWlNUQA2/k0biwcTxzqG6/rcIqJF6kfjCWSzPk4yheVS6A
kIxomffx/nP78r57UPUew5cH3PyYW+x/u/efE+/tbf+wU6Dg/v1+4AtvBsdkgG8myQ32Fx78
Pz3Js3hzenZChzAZXBneCirdWrtLFp5IxbI5xTPl6v68f7QyPJkXz+jbvwEzPgYtmLEJN0Oh
uTYDjgs65tuA8yNjW7tfDlfBqiAqRSywDD07HXTJoobAJJ5P7Mv1kYEuyUCc3dP27X1ETf3C
P5tSL1EA51oUfnl6EghaqGm2ISt1NJP+GxswCejghRbsflrABg3jmkt011DKJDhlgtR7GJd0
bFuHMb2gIwY7jDMmAq85bQvvlN8RAIU3EMsFgItT53oBBpPY08ATJ7icF6dfnC9Y5dYI9H7f
vf4cBLu0VzBF26G1ZuJAGoy0mgnnQQTxyrlfZsDq8nFRZnN7GPvE5M5pcWTp3HmI4NwNAaNt
MuBI/XTSnIV3x9iAm1X1Yum5d1xzF7jvAMaro4UXORcn32yg0Dmb5SqzF6V1WkHBQScTHM8g
FlFnqgIbqn/HpKvV4Gsm8LZ92rmXALwg4ofuXx73z5P04/n79jCZb1+2bTbE8XaWovbzghR3
m48sZq2+joAwt4SGWeR3jDLq8xtWsy9ClATzDcPEKQXjMdLeIkrDzP4WcsFYSW08z3J+sG7O
FTUj4VIF1/qel7TzrzSlTJkCT26SJERZTQl6mG5ovD+3h3cM4QJe7U3lHHnbPb3cq5K7ysVK
26o6kUp5zgENUqk1ZCuessobPU5GeE29YkOoFrXheJxus32uLEKMaA2HImGjPuvgxAQXpjpc
t2+asCEQalMfBM4IK68b93UCJQ5TBoo1LKtS9OOn25AkX7TxIe3kwFDRQ91P8rW/0EbaIoyG
C+8Dowwbmtwp/umljezkaPxalFXN9HVmCTzQ4FZAG5RY+OFswzEePRSODikUr1h5ZM0TDZ+J
0hod2xudsDcWM80pco/RH+BVgSj1SqGE6pXNgpLY2rbNzJvBuVMlG1JF9bu9oFrNXdD/0PUd
tNIv06B65n8j3tJsu77upKUJWO0VDoE6LYXXC91AlS5sUhUjNmhCi2A92LxK+zuobTSP67Ev
XeKBNFygZw9X075JP8AEsgS3/WLmMfpwjw9XYzCxlHABs0xBQFNyNFdifTdiGLA80TA1uEQn
lJiLO8bIv8xR90MiipI7ezOoTSi2Ch1tsq5jaFy5xN0oY+n/Awej6geTxwAA

--+HP7ph2BbKc20aGI--
