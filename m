Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522379753; cv=none;
        d=google.com; s=arc-20160816;
        b=hDkhP08ayF4nRPCopsy3eLfy4B2W/YUVA6xQHVE6yP5VclS6plDu7e9n16kqsKk8Jm
         1vSPw9P6+4w9ZLquOS5XZxwMrnUgnRJzL6nnZIz8UVxy+Ygpw6Gey8DZKm9GFYF1bfFB
         lo2xVNmY+alfmbcstCTf/LAiDt3PBotxDDe+gMMr2/VHaSbKim/EhcnplMxPSu9VVlKn
         a5uuZNiJqempD1p0aLFT6zHdVVuaV4yYf7yzX1LHEmhm3FR0oqsuvVf8KwRsNxFLNWp7
         WNupnGLFgUwvc4sQtKGNO8wZry7yRtx87IjVLF8F6f2uxIUHvhMJ8k7VJNiFM/sSNJwY
         Cj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pJB+Pz9Uw+xSLoAtMuOxEwaBMYgEMWpWLNwwkfSaIF4=;
        b=dUrqcMSgzqrOEvIJz6KO7IFNmZ+opG54MNQlKkREivFPiGj6r73w1876MCYUtCccg+
         /xWH6BAXwDAJBmpmyjQcnDPQWZUkw4h/O0pLwn0AyBq49Sn+/wsJcE2mSxd5JneCGVpR
         2bg0nadsUKWtda7iUdIjNo/iaP5To/6oq9nAJuXi0m5JOHVX872OdSjLopNk4kTWcd5u
         VQyd0wJsEskwDMymcK+36Tx7Ibq3+ngiCoFQDuVBvRIg519iAGGPw4bNGpoPQpL8wPuZ
         WKFRJv9IH4NeuU91m+7r6EIs9ZV8SH+JRpPFbPkI9WMQEu1Cp8Sd6MGFuPGpaO9+pHdC
         wlhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hX6Vub2r;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hX6Vub2r;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+NLkydUh4UOJp/01PIDomhSdjE0hDM3z1vnzng0R0MUUhAN9iOteFdXfRkm6NqxJl0f1odKQ==
From: Leo Yan <leo.yan@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/6] doc: Add Coresight documentation directory
Date: Fri, 30 Mar 2018 11:15:19 +0800
Message-Id: <1522379724-30648-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330872100374567?=
X-GMAIL-MSGID: =?utf-8?q?1596330872100374567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For easy management and friendly adding more Coresight documentation,
this commit creates a new directory: Documentation/trace/coresight.

This commit also moves Coresight related docs into the new directory
and updates MAINTAINERS file to reflect docs movement.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/trace/coresight-cpu-debug.txt        | 187 ----------
 Documentation/trace/coresight.txt                  | 383 ---------------------
 .../trace/coresight/coresight-cpu-debug.txt        | 187 ++++++++++
 Documentation/trace/coresight/coresight.txt        | 383 +++++++++++++++++++++
 MAINTAINERS                                        |   4 +-
 5 files changed, 572 insertions(+), 572 deletions(-)
 delete mode 100644 Documentation/trace/coresight-cpu-debug.txt
 delete mode 100644 Documentation/trace/coresight.txt
 create mode 100644 Documentation/trace/coresight/coresight-cpu-debug.txt
 create mode 100644 Documentation/trace/coresight/coresight.txt

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
deleted file mode 100644
index 2b9b51c..0000000
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ /dev/null
@@ -1,187 +0,0 @@
-		Coresight CPU Debug Module
-		==========================
-
-   Author:   Leo Yan <leo.yan@linaro.org>
-   Date:     April 5th, 2017
-
-Introduction
-------------
-
-Coresight CPU debug module is defined in ARMv8-a architecture reference manual
-(ARM DDI 0487A.k) Chapter 'Part H: External debug', the CPU can integrate
-debug module and it is mainly used for two modes: self-hosted debug and
-external debug. Usually the external debug mode is well known as the external
-debugger connects with SoC from JTAG port; on the other hand the program can
-explore debugging method which rely on self-hosted debug mode, this document
-is to focus on this part.
-
-The debug module provides sample-based profiling extension, which can be used
-to sample CPU program counter, secure state and exception level, etc; usually
-every CPU has one dedicated debug module to be connected. Based on self-hosted
-debug mechanism, Linux kernel can access these related registers from mmio
-region when the kernel panic happens. The callback notifier for kernel panic
-will dump related registers for every CPU; finally this is good for assistant
-analysis for panic.
-
-
-Implementation
---------------
-
-- During driver registration, it uses EDDEVID and EDDEVID1 - two device ID
-  registers to decide if sample-based profiling is implemented or not. On some
-  platforms this hardware feature is fully or partially implemented; and if
-  this feature is not supported then registration will fail.
-
-- At the time this documentation was written, the debug driver mainly relies on
-  information gathered by the kernel panic callback notifier from three
-  sampling registers: EDPCSR, EDVIDSR and EDCIDSR: from EDPCSR we can get
-  program counter; EDVIDSR has information for secure state, exception level,
-  bit width, etc; EDCIDSR is context ID value which contains the sampled value
-  of CONTEXTIDR_EL1.
-
-- The driver supports a CPU running in either AArch64 or AArch32 mode. The
-  registers naming convention is a bit different between them, AArch64 uses
-  'ED' for register prefix (ARM DDI 0487A.k, chapter H9.1) and AArch32 uses
-  'DBG' as prefix (ARM DDI 0487A.k, chapter G5.1). The driver is unified to
-  use AArch64 naming convention.
-
-- ARMv8-a (ARM DDI 0487A.k) and ARMv7-a (ARM DDI 0406C.b) have different
-  register bits definition. So the driver consolidates two difference:
-
-  If PCSROffset=0b0000, on ARMv8-a the feature of EDPCSR is not implemented;
-  but ARMv7-a defines "PCSR samples are offset by a value that depends on the
-  instruction set state". For ARMv7-a, the driver checks furthermore if CPU
-  runs with ARM or thumb instruction set and calibrate PCSR value, the
-  detailed description for offset is in ARMv7-a ARM (ARM DDI 0406C.b) chapter
-  C11.11.34 "DBGPCSR, Program Counter Sampling Register".
-
-  If PCSROffset=0b0010, ARMv8-a defines "EDPCSR implemented, and samples have
-  no offset applied and do not sample the instruction set state in AArch32
-  state". So on ARMv8 if EDDEVID1.PCSROffset is 0b0010 and the CPU operates
-  in AArch32 state, EDPCSR is not sampled; when the CPU operates in AArch64
-  state EDPCSR is sampled and no offset are applied.
-
-
-Clock and power domain
-----------------------
-
-Before accessing debug registers, we should ensure the clock and power domain
-have been enabled properly. In ARMv8-a ARM (ARM DDI 0487A.k) chapter 'H9.1
-Debug registers', the debug registers are spread into two domains: the debug
-domain and the CPU domain.
-
-                                +---------------+
-                                |               |
-                                |               |
-                     +----------+--+            |
-        dbg_clock -->|          |**|            |<-- cpu_clock
-                     |    Debug |**|   CPU      |
- dbg_power_domain -->|          |**|            |<-- cpu_power_domain
-                     +----------+--+            |
-                                |               |
-                                |               |
-                                +---------------+
-
-For debug domain, the user uses DT binding "clocks" and "power-domains" to
-specify the corresponding clock source and power supply for the debug logic.
-The driver calls the pm_runtime_{put|get} operations as needed to handle the
-debug power domain.
-
-For CPU domain, the different SoC designs have different power management
-schemes and finally this heavily impacts external debug module. So we can
-divide into below cases:
-
-- On systems with a sane power controller which can behave correctly with
-  respect to CPU power domain, the CPU power domain can be controlled by
-  register EDPRCR in driver. The driver firstly writes bit EDPRCR.COREPURQ
-  to power up the CPU, and then writes bit EDPRCR.CORENPDRQ for emulation
-  of CPU power down. As result, this can ensure the CPU power domain is
-  powered on properly during the period when access debug related registers;
-
-- Some designs will power down an entire cluster if all CPUs on the cluster
-  are powered down - including the parts of the debug registers that should
-  remain powered in the debug power domain. The bits in EDPRCR are not
-  respected in these cases, so these designs do not support debug over
-  power down in the way that the CoreSight / Debug designers anticipated.
-  This means that even checking EDPRSR has the potential to cause a bus hang
-  if the target register is unpowered.
-
-  In this case, accessing to the debug registers while they are not powered
-  is a recipe for disaster; so we need preventing CPU low power states at boot
-  time or when user enable module at the run time. Please see chapter
-  "How to use the module" for detailed usage info for this.
-
-
-Device Tree Bindings
---------------------
-
-See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
-
-
-How to use the module
----------------------
-
-If you want to enable debugging functionality at boot time, you can add
-"coresight_cpu_debug.enable=1" to the kernel command line parameter.
-
-The driver also can work as module, so can enable the debugging when insmod
-module:
-# insmod coresight_cpu_debug.ko debug=1
-
-When boot time or insmod module you have not enabled the debugging, the driver
-uses the debugfs file system to provide a knob to dynamically enable or disable
-debugging:
-
-To enable it, write a '1' into /sys/kernel/debug/coresight_cpu_debug/enable:
-# echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable
-
-To disable it, write a '0' into /sys/kernel/debug/coresight_cpu_debug/enable:
-# echo 0 > /sys/kernel/debug/coresight_cpu_debug/enable
-
-As explained in chapter "Clock and power domain", if you are working on one
-platform which has idle states to power off debug logic and the power
-controller cannot work well for the request from EDPRCR, then you should
-firstly constraint CPU idle states before enable CPU debugging feature; so can
-ensure the accessing to debug logic.
-
-If you want to limit idle states at boot time, you can use "nohlt" or
-"cpuidle.off=1" in the kernel command line.
-
-At the runtime you can disable idle states with below methods:
-
-It is possible to disable CPU idle states by way of the PM QoS
-subsystem, more specifically by using the "/dev/cpu_dma_latency"
-interface (see Documentation/power/pm_qos_interface.txt for more
-details).  As specified in the PM QoS documentation the requested
-parameter will stay in effect until the file descriptor is released.
-For example:
-
-# exec 3<> /dev/cpu_dma_latency; echo 0 >&3
-...
-Do some work...
-...
-# exec 3<>-
-
-The same can also be done from an application program.
-
-Disable specific CPU's specific idle state from cpuidle sysfs (see
-Documentation/cpuidle/sysfs.txt):
-# echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
-
-
-Output format
--------------
-
-Here is an example of the debugging output format:
-
-ARM external debug module:
-coresight-cpu-debug 850000.debug: CPU[0]:
-coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 850000.debug:  EDPCSR:  [<ffff00000808e9bc>] handle_IPI+0x174/0x1d8
-coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
-coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
-coresight-cpu-debug 852000.debug: CPU[1]:
-coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 852000.debug:  EDPCSR:  [<ffff0000087fab34>] debug_notifier_call+0x23c/0x358
-coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
-coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
deleted file mode 100644
index 6f0120c..0000000
--- a/Documentation/trace/coresight.txt
+++ /dev/null
@@ -1,383 +0,0 @@
-		Coresight - HW Assisted Tracing on ARM
-		======================================
-
-   Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
-   Date:     September 11th, 2014
-
-Introduction
-------------
-
-Coresight is an umbrella of technologies allowing for the debugging of ARM
-based SoC.  It includes solutions for JTAG and HW assisted tracing.  This
-document is concerned with the latter.
-
-HW assisted tracing is becoming increasingly useful when dealing with systems
-that have many SoCs and other components like GPU and DMA engines.  ARM has
-developed a HW assisted tracing solution by means of different components, each
-being added to a design at synthesis time to cater to specific tracing needs.
-Components are generally categorised as source, link and sinks and are
-(usually) discovered using the AMBA bus.
-
-"Sources" generate a compressed stream representing the processor instruction
-path based on tracing scenarios as configured by users.  From there the stream
-flows through the coresight system (via ATB bus) using links that are connecting
-the emanating source to a sink(s).  Sinks serve as endpoints to the coresight
-implementation, either storing the compressed stream in a memory buffer or
-creating an interface to the outside world where data can be transferred to a
-host without fear of filling up the onboard coresight memory buffer.
-
-At typical coresight system would look like this:
-
-  *****************************************************************
- **************************** AMBA AXI  ****************************===||
-  *****************************************************************    ||
-        ^                    ^                            |            ||
-        |                    |                            *            **
-     0000000    :::::     0000000    :::::    :::::    @@@@@@@    ||||||||||||
-     0 CPU 0<-->: C :     0 CPU 0<-->: C :    : C :    @ STM @    || System ||
-  |->0000000    : T :  |->0000000    : T :    : T :<--->@@@@@     || Memory ||
-  |  #######<-->: I :  |  #######<-->: I :    : I :      @@@<-|   ||||||||||||
-  |  # ETM #    :::::  |  # PTM #    :::::    :::::       @   |
-  |   #####      ^ ^   |   #####      ^ !      ^ !        .   |   |||||||||
-  | |->###       | !   | |->###       | !      | !        .   |   || DAP ||
-  | |   #        | !   | |   #        | !      | !        .   |   |||||||||
-  | |   .        | !   | |   .        | !      | !        .   |      |  |
-  | |   .        | !   | |   .        | !      | !        .   |      |  *
-  | |   .        | !   | |   .        | !      | !        .   |      | SWD/
-  | |   .        | !   | |   .        | !      | !        .   |      | JTAG
-  *****************************************************************<-|
- *************************** AMBA Debug APB ************************
-  *****************************************************************
-   |    .          !         .          !        !        .    |
-   |    .          *         .          *        *        .    |
-  *****************************************************************
- ******************** Cross Trigger Matrix (CTM) *******************
-  *****************************************************************
-   |    .     ^              .                            .    |
-   |    *     !              *                            *    |
-  *****************************************************************
- ****************** AMBA Advanced Trace Bus (ATB) ******************
-  *****************************************************************
-   |          !                        ===============         |
-   |          *                         ===== F =====<---------|
-   |   :::::::::                         ==== U ====
-   |-->:: CTI ::<!!                       === N ===
-   |   :::::::::  !                        == N ==
-   |    ^         *                        == E ==
-   |    !  &&&&&&&&&       IIIIIII         == L ==
-   |------>&& ETB &&<......II     I        =======
-   |    !  &&&&&&&&&       II     I           .
-   |    !                    I     I          .
-   |    !                    I REP I<..........
-   |    !                    I     I
-   |    !!>&&&&&&&&&       II     I           *Source: ARM ltd.
-   |------>& TPIU  &<......II    I            DAP = Debug Access Port
-           &&&&&&&&&       IIIIIII            ETM = Embedded Trace Macrocell
-               ;                              PTM = Program Trace Macrocell
-               ;                              CTI = Cross Trigger Interface
-               *                              ETB = Embedded Trace Buffer
-          To trace port                       TPIU= Trace Port Interface Unit
-                                              SWD = Serial Wire Debug
-
-While on target configuration of the components is done via the APB bus,
-all trace data are carried out-of-band on the ATB bus.  The CTM provides
-a way to aggregate and distribute signals between CoreSight components.
-
-The coresight framework provides a central point to represent, configure and
-manage coresight devices on a platform.  This first implementation centers on
-the basic tracing functionality, enabling components such ETM/PTM, funnel,
-replicator, TMC, TPIU and ETB.  Future work will enable more
-intricate IP blocks such as STM and CTI.
-
-
-Acronyms and Classification
----------------------------
-
-Acronyms:
-
-PTM:     Program Trace Macrocell
-ETM:     Embedded Trace Macrocell
-STM:     System trace Macrocell
-ETB:     Embedded Trace Buffer
-ITM:     Instrumentation Trace Macrocell
-TPIU:    Trace Port Interface Unit
-TMC-ETR: Trace Memory Controller, configured as Embedded Trace Router
-TMC-ETF: Trace Memory Controller, configured as Embedded Trace FIFO
-CTI:     Cross Trigger Interface
-
-Classification:
-
-Source:
-   ETMv3.x ETMv4, PTMv1.0, PTMv1.1, STM, STM500, ITM
-Link:
-   Funnel, replicator (intelligent or not), TMC-ETR
-Sinks:
-   ETBv1.0, ETB1.1, TPIU, TMC-ETF
-Misc:
-   CTI
-
-
-Device Tree Bindings
-----------------------
-
-See Documentation/devicetree/bindings/arm/coresight.txt for details.
-
-As of this writing drivers for ITM, STMs and CTIs are not provided but are
-expected to be added as the solution matures.
-
-
-Framework and implementation
-----------------------------
-
-The coresight framework provides a central point to represent, configure and
-manage coresight devices on a platform.  Any coresight compliant device can
-register with the framework for as long as they use the right APIs:
-
-struct coresight_device *coresight_register(struct coresight_desc *desc);
-void coresight_unregister(struct coresight_device *csdev);
-
-The registering function is taking a "struct coresight_device *csdev" and
-register the device with the core framework.  The unregister function takes
-a reference to a "struct coresight_device", obtained at registration time.
-
-If everything goes well during the registration process the new devices will
-show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
-
-root:~# ls /sys/bus/coresight/devices/
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
-root:~#
-
-The functions take a "struct coresight_device", which looks like this:
-
-struct coresight_desc {
-        enum coresight_dev_type type;
-        struct coresight_dev_subtype subtype;
-        const struct coresight_ops *ops;
-        struct coresight_platform_data *pdata;
-        struct device *dev;
-        const struct attribute_group **groups;
-};
-
-
-The "coresight_dev_type" identifies what the device is, i.e, source link or
-sink while the "coresight_dev_subtype" will characterise that type further.
-
-The "struct coresight_ops" is mandatory and will tell the framework how to
-perform base operations related to the components, each component having
-a different set of requirement.  For that "struct coresight_ops_sink",
-"struct coresight_ops_link" and "struct coresight_ops_source" have been
-provided.
-
-The next field, "struct coresight_platform_data *pdata" is acquired by calling
-"of_get_coresight_platform_data()", as part of the driver's _probe routine and
-"struct device *dev" gets the device reference embedded in the "amba_device":
-
-static int etm_probe(struct amba_device *adev, const struct amba_id *id)
-{
- ...
- ...
- drvdata->dev = &adev->dev;
- ...
-}
-
-Specific class of device (source, link, or sink) have generic operations
-that can be performed on them (see "struct coresight_ops").  The
-"**groups" is a list of sysfs entries pertaining to operations
-specific to that component only.  "Implementation defined" customisations are
-expected to be accessed and controlled using those entries.
-
-Last but not least, "struct module *owner" is expected to be set to reflect
-the information carried in "THIS_MODULE".
-
-How to use the tracer modules
------------------------------
-
-Before trace collection can start, a coresight sink needs to be identify.
-There is no limit on the amount of sinks (nor sources) that can be enabled at
-any given moment.  As a generic operation, all device pertaining to the sink
-class will have an "active" entry in sysfs:
-
-root:/sys/bus/coresight/devices# ls
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
-root:/sys/bus/coresight/devices# ls 20010000.etb
-enable_sink  status  trigger_cntr
-root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
-root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
-1
-root:/sys/bus/coresight/devices#
-
-At boot time the current etm3x driver will configure the first address
-comparator with "_stext" and "_etext", essentially tracing any instruction
-that falls within that range.  As such "enabling" a source will immediately
-trigger a trace capture:
-
-root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
-root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
-1
-root:/sys/bus/coresight/devices# cat 20010000.etb/status
-Depth:          0x2000
-Status:         0x1
-RAM read ptr:   0x0
-RAM wrt ptr:    0x19d3   <----- The write pointer is moving
-Trigger cnt:    0x0
-Control:        0x1
-Flush status:   0x0
-Flush ctrl:     0x2001
-root:/sys/bus/coresight/devices#
-
-Trace collection is stopped the same way:
-
-root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
-root:/sys/bus/coresight/devices#
-
-The content of the ETB buffer can be harvested directly from /dev:
-
-root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
-of=~/cstrace.bin
-
-64+0 records in
-64+0 records out
-32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
-root:/sys/bus/coresight/devices#
-
-The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.
-
-Following is a DS-5 output of an experimental loop that increments a variable up
-to a certain value.  The example is simple and yet provides a glimpse of the
-wealth of possibilities that coresight provides.
-
-Info                                    Tracing enabled
-Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
-Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
-Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
-Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Timestamp                                       Timestamp: 17106715833
-Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
-Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
-Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
-Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
-Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
-Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
-Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
-Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
-Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
-Info                                    Tracing enabled
-Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
-Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
-Timestamp                                       Timestamp: 17107041535
-
-How to use the STM module
--------------------------
-
-Using the System Trace Macrocell module is the same as the tracers - the only
-difference is that clients are driving the trace capture rather
-than the program flow through the code.
-
-As with any other CoreSight component, specifics about the STM tracer can be
-found in sysfs with more information on each entry being found in [1]:
-
-root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
-enable_source   hwevent_select  port_enable     subsystem       uevent
-hwevent_enable  mgmt            port_select     traceid
-root@genericarmv8:~#
-
-Like any other source a sink needs to be identified and the STM enabled before
-being used:
-
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
-
-From there user space applications can request and use channels using the devfs
-interface provided for that purpose by the generic STM API:
-
-root@genericarmv8:~# ls -l /dev/20100000.stm
-crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
-root@genericarmv8:~#
-
-Details on how to use the generic STM API can be found here [2].
-
-[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.txt
-
-
-Using perf tools
-----------------
-
-perf can be used to record and analyze trace of programs.
-
-Execution can be recorded using 'perf record' with the cs_etm event,
-specifying the name of the sink to record to, e.g:
-
-    perf record -e cs_etm/@20070000.etr/u --per-thread
-
-The 'perf report' and 'perf script' commands can be used to analyze execution,
-synthesizing instruction and branch events from the instruction trace.
-'perf inject' can be used to replace the trace data with the synthesized events.
-The --itrace option controls the type and frequency of synthesized events
-(see perf documentation).
-
-Note that only 64-bit programs are currently supported - further work is
-required to support instruction decode of 32-bit Arm programs.
-
-
-Generating coverage files for Feedback Directed Optimization: AutoFDO
----------------------------------------------------------------------
-
-'perf inject' accepts the --itrace option in which case tracing data is
-removed and replaced with the synthesized events. e.g.
-
-	perf inject --itrace --strip -i perf.data -o perf.data.new
-
-Below is an example of using ARM ETM for autoFDO.  It requires autofdo
-(https://github.com/google/autofdo) and gcc version 5.  The bubble
-sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
-
-	$ gcc-5 -O3 sort.c -o sort
-	$ taskset -c 2 ./sort
-	Bubble sorting array of 30000 elements
-	5910 ms
-
-	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
-	Bubble sorting array of 30000 elements
-	12543 ms
-	[ perf record: Woken up 35 times to write data ]
-	[ perf record: Captured and wrote 69.640 MB perf.data ]
-
-	$ perf inject -i perf.data -o inj.data --itrace=il64 --strip
-	$ create_gcov --binary=./sort --profile=inj.data --gcov=sort.gcov -gcov_version=1
-	$ gcc-5 -O3 -fauto-profile=sort.gcov sort.c -o sort_autofdo
-	$ taskset -c 2 ./sort_autofdo
-	Bubble sorting array of 30000 elements
-	5806 ms
diff --git a/Documentation/trace/coresight/coresight-cpu-debug.txt b/Documentation/trace/coresight/coresight-cpu-debug.txt
new file mode 100644
index 0000000..2b9b51c
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-cpu-debug.txt
@@ -0,0 +1,187 @@
+		Coresight CPU Debug Module
+		==========================
+
+   Author:   Leo Yan <leo.yan@linaro.org>
+   Date:     April 5th, 2017
+
+Introduction
+------------
+
+Coresight CPU debug module is defined in ARMv8-a architecture reference manual
+(ARM DDI 0487A.k) Chapter 'Part H: External debug', the CPU can integrate
+debug module and it is mainly used for two modes: self-hosted debug and
+external debug. Usually the external debug mode is well known as the external
+debugger connects with SoC from JTAG port; on the other hand the program can
+explore debugging method which rely on self-hosted debug mode, this document
+is to focus on this part.
+
+The debug module provides sample-based profiling extension, which can be used
+to sample CPU program counter, secure state and exception level, etc; usually
+every CPU has one dedicated debug module to be connected. Based on self-hosted
+debug mechanism, Linux kernel can access these related registers from mmio
+region when the kernel panic happens. The callback notifier for kernel panic
+will dump related registers for every CPU; finally this is good for assistant
+analysis for panic.
+
+
+Implementation
+--------------
+
+- During driver registration, it uses EDDEVID and EDDEVID1 - two device ID
+  registers to decide if sample-based profiling is implemented or not. On some
+  platforms this hardware feature is fully or partially implemented; and if
+  this feature is not supported then registration will fail.
+
+- At the time this documentation was written, the debug driver mainly relies on
+  information gathered by the kernel panic callback notifier from three
+  sampling registers: EDPCSR, EDVIDSR and EDCIDSR: from EDPCSR we can get
+  program counter; EDVIDSR has information for secure state, exception level,
+  bit width, etc; EDCIDSR is context ID value which contains the sampled value
+  of CONTEXTIDR_EL1.
+
+- The driver supports a CPU running in either AArch64 or AArch32 mode. The
+  registers naming convention is a bit different between them, AArch64 uses
+  'ED' for register prefix (ARM DDI 0487A.k, chapter H9.1) and AArch32 uses
+  'DBG' as prefix (ARM DDI 0487A.k, chapter G5.1). The driver is unified to
+  use AArch64 naming convention.
+
+- ARMv8-a (ARM DDI 0487A.k) and ARMv7-a (ARM DDI 0406C.b) have different
+  register bits definition. So the driver consolidates two difference:
+
+  If PCSROffset=0b0000, on ARMv8-a the feature of EDPCSR is not implemented;
+  but ARMv7-a defines "PCSR samples are offset by a value that depends on the
+  instruction set state". For ARMv7-a, the driver checks furthermore if CPU
+  runs with ARM or thumb instruction set and calibrate PCSR value, the
+  detailed description for offset is in ARMv7-a ARM (ARM DDI 0406C.b) chapter
+  C11.11.34 "DBGPCSR, Program Counter Sampling Register".
+
+  If PCSROffset=0b0010, ARMv8-a defines "EDPCSR implemented, and samples have
+  no offset applied and do not sample the instruction set state in AArch32
+  state". So on ARMv8 if EDDEVID1.PCSROffset is 0b0010 and the CPU operates
+  in AArch32 state, EDPCSR is not sampled; when the CPU operates in AArch64
+  state EDPCSR is sampled and no offset are applied.
+
+
+Clock and power domain
+----------------------
+
+Before accessing debug registers, we should ensure the clock and power domain
+have been enabled properly. In ARMv8-a ARM (ARM DDI 0487A.k) chapter 'H9.1
+Debug registers', the debug registers are spread into two domains: the debug
+domain and the CPU domain.
+
+                                +---------------+
+                                |               |
+                                |               |
+                     +----------+--+            |
+        dbg_clock -->|          |**|            |<-- cpu_clock
+                     |    Debug |**|   CPU      |
+ dbg_power_domain -->|          |**|            |<-- cpu_power_domain
+                     +----------+--+            |
+                                |               |
+                                |               |
+                                +---------------+
+
+For debug domain, the user uses DT binding "clocks" and "power-domains" to
+specify the corresponding clock source and power supply for the debug logic.
+The driver calls the pm_runtime_{put|get} operations as needed to handle the
+debug power domain.
+
+For CPU domain, the different SoC designs have different power management
+schemes and finally this heavily impacts external debug module. So we can
+divide into below cases:
+
+- On systems with a sane power controller which can behave correctly with
+  respect to CPU power domain, the CPU power domain can be controlled by
+  register EDPRCR in driver. The driver firstly writes bit EDPRCR.COREPURQ
+  to power up the CPU, and then writes bit EDPRCR.CORENPDRQ for emulation
+  of CPU power down. As result, this can ensure the CPU power domain is
+  powered on properly during the period when access debug related registers;
+
+- Some designs will power down an entire cluster if all CPUs on the cluster
+  are powered down - including the parts of the debug registers that should
+  remain powered in the debug power domain. The bits in EDPRCR are not
+  respected in these cases, so these designs do not support debug over
+  power down in the way that the CoreSight / Debug designers anticipated.
+  This means that even checking EDPRSR has the potential to cause a bus hang
+  if the target register is unpowered.
+
+  In this case, accessing to the debug registers while they are not powered
+  is a recipe for disaster; so we need preventing CPU low power states at boot
+  time or when user enable module at the run time. Please see chapter
+  "How to use the module" for detailed usage info for this.
+
+
+Device Tree Bindings
+--------------------
+
+See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
+
+
+How to use the module
+---------------------
+
+If you want to enable debugging functionality at boot time, you can add
+"coresight_cpu_debug.enable=1" to the kernel command line parameter.
+
+The driver also can work as module, so can enable the debugging when insmod
+module:
+# insmod coresight_cpu_debug.ko debug=1
+
+When boot time or insmod module you have not enabled the debugging, the driver
+uses the debugfs file system to provide a knob to dynamically enable or disable
+debugging:
+
+To enable it, write a '1' into /sys/kernel/debug/coresight_cpu_debug/enable:
+# echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable
+
+To disable it, write a '0' into /sys/kernel/debug/coresight_cpu_debug/enable:
+# echo 0 > /sys/kernel/debug/coresight_cpu_debug/enable
+
+As explained in chapter "Clock and power domain", if you are working on one
+platform which has idle states to power off debug logic and the power
+controller cannot work well for the request from EDPRCR, then you should
+firstly constraint CPU idle states before enable CPU debugging feature; so can
+ensure the accessing to debug logic.
+
+If you want to limit idle states at boot time, you can use "nohlt" or
+"cpuidle.off=1" in the kernel command line.
+
+At the runtime you can disable idle states with below methods:
+
+It is possible to disable CPU idle states by way of the PM QoS
+subsystem, more specifically by using the "/dev/cpu_dma_latency"
+interface (see Documentation/power/pm_qos_interface.txt for more
+details).  As specified in the PM QoS documentation the requested
+parameter will stay in effect until the file descriptor is released.
+For example:
+
+# exec 3<> /dev/cpu_dma_latency; echo 0 >&3
+...
+Do some work...
+...
+# exec 3<>-
+
+The same can also be done from an application program.
+
+Disable specific CPU's specific idle state from cpuidle sysfs (see
+Documentation/cpuidle/sysfs.txt):
+# echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
+
+
+Output format
+-------------
+
+Here is an example of the debugging output format:
+
+ARM external debug module:
+coresight-cpu-debug 850000.debug: CPU[0]:
+coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
+coresight-cpu-debug 850000.debug:  EDPCSR:  [<ffff00000808e9bc>] handle_IPI+0x174/0x1d8
+coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
+coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
+coresight-cpu-debug 852000.debug: CPU[1]:
+coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
+coresight-cpu-debug 852000.debug:  EDPCSR:  [<ffff0000087fab34>] debug_notifier_call+0x23c/0x358
+coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
+coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
diff --git a/Documentation/trace/coresight/coresight.txt b/Documentation/trace/coresight/coresight.txt
new file mode 100644
index 0000000..6f0120c
--- /dev/null
+++ b/Documentation/trace/coresight/coresight.txt
@@ -0,0 +1,383 @@
+		Coresight - HW Assisted Tracing on ARM
+		======================================
+
+   Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
+   Date:     September 11th, 2014
+
+Introduction
+------------
+
+Coresight is an umbrella of technologies allowing for the debugging of ARM
+based SoC.  It includes solutions for JTAG and HW assisted tracing.  This
+document is concerned with the latter.
+
+HW assisted tracing is becoming increasingly useful when dealing with systems
+that have many SoCs and other components like GPU and DMA engines.  ARM has
+developed a HW assisted tracing solution by means of different components, each
+being added to a design at synthesis time to cater to specific tracing needs.
+Components are generally categorised as source, link and sinks and are
+(usually) discovered using the AMBA bus.
+
+"Sources" generate a compressed stream representing the processor instruction
+path based on tracing scenarios as configured by users.  From there the stream
+flows through the coresight system (via ATB bus) using links that are connecting
+the emanating source to a sink(s).  Sinks serve as endpoints to the coresight
+implementation, either storing the compressed stream in a memory buffer or
+creating an interface to the outside world where data can be transferred to a
+host without fear of filling up the onboard coresight memory buffer.
+
+At typical coresight system would look like this:
+
+  *****************************************************************
+ **************************** AMBA AXI  ****************************===||
+  *****************************************************************    ||
+        ^                    ^                            |            ||
+        |                    |                            *            **
+     0000000    :::::     0000000    :::::    :::::    @@@@@@@    ||||||||||||
+     0 CPU 0<-->: C :     0 CPU 0<-->: C :    : C :    @ STM @    || System ||
+  |->0000000    : T :  |->0000000    : T :    : T :<--->@@@@@     || Memory ||
+  |  #######<-->: I :  |  #######<-->: I :    : I :      @@@<-|   ||||||||||||
+  |  # ETM #    :::::  |  # PTM #    :::::    :::::       @   |
+  |   #####      ^ ^   |   #####      ^ !      ^ !        .   |   |||||||||
+  | |->###       | !   | |->###       | !      | !        .   |   || DAP ||
+  | |   #        | !   | |   #        | !      | !        .   |   |||||||||
+  | |   .        | !   | |   .        | !      | !        .   |      |  |
+  | |   .        | !   | |   .        | !      | !        .   |      |  *
+  | |   .        | !   | |   .        | !      | !        .   |      | SWD/
+  | |   .        | !   | |   .        | !      | !        .   |      | JTAG
+  *****************************************************************<-|
+ *************************** AMBA Debug APB ************************
+  *****************************************************************
+   |    .          !         .          !        !        .    |
+   |    .          *         .          *        *        .    |
+  *****************************************************************
+ ******************** Cross Trigger Matrix (CTM) *******************
+  *****************************************************************
+   |    .     ^              .                            .    |
+   |    *     !              *                            *    |
+  *****************************************************************
+ ****************** AMBA Advanced Trace Bus (ATB) ******************
+  *****************************************************************
+   |          !                        ===============         |
+   |          *                         ===== F =====<---------|
+   |   :::::::::                         ==== U ====
+   |-->:: CTI ::<!!                       === N ===
+   |   :::::::::  !                        == N ==
+   |    ^         *                        == E ==
+   |    !  &&&&&&&&&       IIIIIII         == L ==
+   |------>&& ETB &&<......II     I        =======
+   |    !  &&&&&&&&&       II     I           .
+   |    !                    I     I          .
+   |    !                    I REP I<..........
+   |    !                    I     I
+   |    !!>&&&&&&&&&       II     I           *Source: ARM ltd.
+   |------>& TPIU  &<......II    I            DAP = Debug Access Port
+           &&&&&&&&&       IIIIIII            ETM = Embedded Trace Macrocell
+               ;                              PTM = Program Trace Macrocell
+               ;                              CTI = Cross Trigger Interface
+               *                              ETB = Embedded Trace Buffer
+          To trace port                       TPIU= Trace Port Interface Unit
+                                              SWD = Serial Wire Debug
+
+While on target configuration of the components is done via the APB bus,
+all trace data are carried out-of-band on the ATB bus.  The CTM provides
+a way to aggregate and distribute signals between CoreSight components.
+
+The coresight framework provides a central point to represent, configure and
+manage coresight devices on a platform.  This first implementation centers on
+the basic tracing functionality, enabling components such ETM/PTM, funnel,
+replicator, TMC, TPIU and ETB.  Future work will enable more
+intricate IP blocks such as STM and CTI.
+
+
+Acronyms and Classification
+---------------------------
+
+Acronyms:
+
+PTM:     Program Trace Macrocell
+ETM:     Embedded Trace Macrocell
+STM:     System trace Macrocell
+ETB:     Embedded Trace Buffer
+ITM:     Instrumentation Trace Macrocell
+TPIU:    Trace Port Interface Unit
+TMC-ETR: Trace Memory Controller, configured as Embedded Trace Router
+TMC-ETF: Trace Memory Controller, configured as Embedded Trace FIFO
+CTI:     Cross Trigger Interface
+
+Classification:
+
+Source:
+   ETMv3.x ETMv4, PTMv1.0, PTMv1.1, STM, STM500, ITM
+Link:
+   Funnel, replicator (intelligent or not), TMC-ETR
+Sinks:
+   ETBv1.0, ETB1.1, TPIU, TMC-ETF
+Misc:
+   CTI
+
+
+Device Tree Bindings
+----------------------
+
+See Documentation/devicetree/bindings/arm/coresight.txt for details.
+
+As of this writing drivers for ITM, STMs and CTIs are not provided but are
+expected to be added as the solution matures.
+
+
+Framework and implementation
+----------------------------
+
+The coresight framework provides a central point to represent, configure and
+manage coresight devices on a platform.  Any coresight compliant device can
+register with the framework for as long as they use the right APIs:
+
+struct coresight_device *coresight_register(struct coresight_desc *desc);
+void coresight_unregister(struct coresight_device *csdev);
+
+The registering function is taking a "struct coresight_device *csdev" and
+register the device with the core framework.  The unregister function takes
+a reference to a "struct coresight_device", obtained at registration time.
+
+If everything goes well during the registration process the new devices will
+show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
+
+root:~# ls /sys/bus/coresight/devices/
+replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
+20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+root:~#
+
+The functions take a "struct coresight_device", which looks like this:
+
+struct coresight_desc {
+        enum coresight_dev_type type;
+        struct coresight_dev_subtype subtype;
+        const struct coresight_ops *ops;
+        struct coresight_platform_data *pdata;
+        struct device *dev;
+        const struct attribute_group **groups;
+};
+
+
+The "coresight_dev_type" identifies what the device is, i.e, source link or
+sink while the "coresight_dev_subtype" will characterise that type further.
+
+The "struct coresight_ops" is mandatory and will tell the framework how to
+perform base operations related to the components, each component having
+a different set of requirement.  For that "struct coresight_ops_sink",
+"struct coresight_ops_link" and "struct coresight_ops_source" have been
+provided.
+
+The next field, "struct coresight_platform_data *pdata" is acquired by calling
+"of_get_coresight_platform_data()", as part of the driver's _probe routine and
+"struct device *dev" gets the device reference embedded in the "amba_device":
+
+static int etm_probe(struct amba_device *adev, const struct amba_id *id)
+{
+ ...
+ ...
+ drvdata->dev = &adev->dev;
+ ...
+}
+
+Specific class of device (source, link, or sink) have generic operations
+that can be performed on them (see "struct coresight_ops").  The
+"**groups" is a list of sysfs entries pertaining to operations
+specific to that component only.  "Implementation defined" customisations are
+expected to be accessed and controlled using those entries.
+
+Last but not least, "struct module *owner" is expected to be set to reflect
+the information carried in "THIS_MODULE".
+
+How to use the tracer modules
+-----------------------------
+
+Before trace collection can start, a coresight sink needs to be identify.
+There is no limit on the amount of sinks (nor sources) that can be enabled at
+any given moment.  As a generic operation, all device pertaining to the sink
+class will have an "active" entry in sysfs:
+
+root:/sys/bus/coresight/devices# ls
+replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
+20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+root:/sys/bus/coresight/devices# ls 20010000.etb
+enable_sink  status  trigger_cntr
+root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
+root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
+1
+root:/sys/bus/coresight/devices#
+
+At boot time the current etm3x driver will configure the first address
+comparator with "_stext" and "_etext", essentially tracing any instruction
+that falls within that range.  As such "enabling" a source will immediately
+trigger a trace capture:
+
+root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
+root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
+1
+root:/sys/bus/coresight/devices# cat 20010000.etb/status
+Depth:          0x2000
+Status:         0x1
+RAM read ptr:   0x0
+RAM wrt ptr:    0x19d3   <----- The write pointer is moving
+Trigger cnt:    0x0
+Control:        0x1
+Flush status:   0x0
+Flush ctrl:     0x2001
+root:/sys/bus/coresight/devices#
+
+Trace collection is stopped the same way:
+
+root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
+root:/sys/bus/coresight/devices#
+
+The content of the ETB buffer can be harvested directly from /dev:
+
+root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
+of=~/cstrace.bin
+
+64+0 records in
+64+0 records out
+32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
+root:/sys/bus/coresight/devices#
+
+The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.
+
+Following is a DS-5 output of an experimental loop that increments a variable up
+to a certain value.  The example is simple and yet provides a glimpse of the
+wealth of possibilities that coresight provides.
+
+Info                                    Tracing enabled
+Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
+Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
+Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
+Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Timestamp                                       Timestamp: 17106715833
+Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
+Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
+Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
+Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
+Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
+Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
+Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
+Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
+Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
+Info                                    Tracing enabled
+Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
+Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
+Timestamp                                       Timestamp: 17107041535
+
+How to use the STM module
+-------------------------
+
+Using the System Trace Macrocell module is the same as the tracers - the only
+difference is that clients are driving the trace capture rather
+than the program flow through the code.
+
+As with any other CoreSight component, specifics about the STM tracer can be
+found in sysfs with more information on each entry being found in [1]:
+
+root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
+enable_source   hwevent_select  port_enable     subsystem       uevent
+hwevent_enable  mgmt            port_select     traceid
+root@genericarmv8:~#
+
+Like any other source a sink needs to be identified and the STM enabled before
+being used:
+
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
+
+From there user space applications can request and use channels using the devfs
+interface provided for that purpose by the generic STM API:
+
+root@genericarmv8:~# ls -l /dev/20100000.stm
+crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
+root@genericarmv8:~#
+
+Details on how to use the generic STM API can be found here [2].
+
+[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
+[2]. Documentation/trace/stm.txt
+
+
+Using perf tools
+----------------
+
+perf can be used to record and analyze trace of programs.
+
+Execution can be recorded using 'perf record' with the cs_etm event,
+specifying the name of the sink to record to, e.g:
+
+    perf record -e cs_etm/@20070000.etr/u --per-thread
+
+The 'perf report' and 'perf script' commands can be used to analyze execution,
+synthesizing instruction and branch events from the instruction trace.
+'perf inject' can be used to replace the trace data with the synthesized events.
+The --itrace option controls the type and frequency of synthesized events
+(see perf documentation).
+
+Note that only 64-bit programs are currently supported - further work is
+required to support instruction decode of 32-bit Arm programs.
+
+
+Generating coverage files for Feedback Directed Optimization: AutoFDO
+---------------------------------------------------------------------
+
+'perf inject' accepts the --itrace option in which case tracing data is
+removed and replaced with the synthesized events. e.g.
+
+	perf inject --itrace --strip -i perf.data -o perf.data.new
+
+Below is an example of using ARM ETM for autoFDO.  It requires autofdo
+(https://github.com/google/autofdo) and gcc version 5.  The bubble
+sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
+
+	$ gcc-5 -O3 sort.c -o sort
+	$ taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	5910 ms
+
+	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	12543 ms
+	[ perf record: Woken up 35 times to write data ]
+	[ perf record: Captured and wrote 69.640 MB perf.data ]
+
+	$ perf inject -i perf.data -o inj.data --itrace=il64 --strip
+	$ create_gcov --binary=./sort --profile=inj.data --gcov=sort.gcov -gcov_version=1
+	$ gcc-5 -O3 -fauto-profile=sort.gcov sort.c -o sort_autofdo
+	$ taskset -c 2 ./sort_autofdo
+	Bubble sorting array of 30000 elements
+	5806 ms
diff --git a/MAINTAINERS b/MAINTAINERS
index 205c8fc..7ee1fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,8 +1331,8 @@ M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
-F:	Documentation/trace/coresight.txt
-F:	Documentation/trace/coresight-cpu-debug.txt
+F:	Documentation/trace/coresight/coresight.txt
+F:	Documentation/trace/coresight/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
-- 
2.7.4
