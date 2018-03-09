Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeCIM6p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:58:45 -0500
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:45576 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeCIM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:58:43 -0500
Date: Fri, 9 Mar 2018 13:51:07 +0100
From: "Alvaro G. M." <alvaro.gamez@hazent.com>
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
Message-ID: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d38b
makes microblaze unbootable.

I'm sorry I can't provide any console output, as nothing appears at all,
even when setting earlyprintk (or at least I wasn't able to get anything
back!).

I'm providing both dts and defconfig in case it helps.

Best regards

CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_FHANDLE=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_BLK_DEV_INITRD=y
CONFIG_EMBEDDED=y
CONFIG_SLAB=y
CONFIG_MODULES=y
CONFIG_KERNEL_BASE_ADDR=0x80000000
CONFIG_XILINX_MICROBLAZE0_FAMILY="artix7"
CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=1
CONFIG_XILINX_MICROBLAZE0_USE_BARREL=1
CONFIG_XILINX_MICROBLAZE0_USE_DIV=1
CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=2
CONFIG_HZ_100=y
CONFIG_MMU=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyUL0,9600"
CONFIG_HIGHMEM=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_M25P80=y
CONFIG_MTD_SPI_NOR=y
CONFIG_NETDEVICES=y
CONFIG_XILINX_EMACLITE=y
CONFIG_DP83848_PHY=y
CONFIG_DP83620_PHY=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_XILINX=y
CONFIG_SPI=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_SPIDEV=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_XILINX=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_FB=y
CONFIG_FB_XILINX=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_UIO=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_IIO=y
CONFIG_AD799X=y
CONFIG_XILINX_XADC=y
CONFIG_PWM=y
CONFIG_JFFS2_FS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SLAB=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_EARLY_PRINTK=y
CONFIG_CRYPTO_MANAGER=y

/dts-v1/;
/ {
	#address-cells = <1>;
	#size-cells = <1>;
	compatible = "xlnx,microblaze";
	model = "Xilinx MicroBlaze";
	cpus {
		#address-cells = <1>;
		#cpus = <1>;
		#size-cells = <0>;
		microblaze_0: cpu@0 {
			bus-handle = <&amba_pl>;
			clock-frequency = <83250000>;
			clocks = <&clk_cpu>;
			compatible = "xlnx,microblaze-9.5";
			d-cache-baseaddr = <0x80000000>;
			d-cache-highaddr = <0x8fffffff>;
			d-cache-line-size = <0x10>;
			d-cache-size = <0x8000>;
			device_type = "cpu";
			i-cache-baseaddr = <0x80000000>;
			i-cache-highaddr = <0x8fffffff>;
			i-cache-line-size = <0x20>;
			i-cache-size = <0x8000>;
			interrupt-handle = <&microblaze_0_axi_intc>;
			model = "microblaze,9.5";
			timebase-frequency = <83250000>;
			xlnx,addr-tag-bits = <0xd>;
			xlnx,allow-dcache-wr = <0x1>;
			xlnx,allow-icache-wr = <0x1>;
			xlnx,area-optimized = <0x0>;
			xlnx,async-interrupt = <0x1>;
			xlnx,avoid-primitives = <0x0>;
			xlnx,base-vectors = <0x00000000>;
			xlnx,branch-target-cache-size = <0x0>;
			xlnx,cache-byte-size = <0x8000>;
			xlnx,d-axi = <0x1>;
			xlnx,d-lmb = <0x1>;
			xlnx,d-lmb-mon = <0x0>;
			xlnx,data-size = <0x20>;
			xlnx,dc-axi-mon = <0x0>;
			xlnx,dcache-addr-tag = <0xd>;
			xlnx,dcache-always-used = <0x1>;
			xlnx,dcache-byte-size = <0x8000>;
			xlnx,dcache-data-width = <0x0>;
			xlnx,dcache-force-tag-lutram = <0x0>;
			xlnx,dcache-line-len = <0x4>;
			xlnx,dcache-use-writeback = <0x0>;
			xlnx,dcache-victims = <0x8>;
			xlnx,debug-counter-width = <0x20>;
			xlnx,debug-enabled = <0x1>;
			xlnx,debug-event-counters = <0x5>;
			xlnx,debug-external-trace = <0x0>;
			xlnx,debug-latency-counters = <0x1>;
			xlnx,debug-profile-size = <0x0>;
			xlnx,debug-trace-size = <0x2000>;
			xlnx,div-zero-exception = <0x1>;
			xlnx,dp-axi-mon = <0x0>;
			xlnx,dynamic-bus-sizing = <0x0>;
			xlnx,ecc-use-ce-exception = <0x0>;
			xlnx,edge-is-positive = <0x1>;
			xlnx,enable-discrete-ports = <0x0>;
			xlnx,endianness = <0x1>;
			xlnx,fault-tolerant = <0x0>;
			xlnx,fpu-exception = <0x0>;
			xlnx,freq = <0x4f64b50>;
			xlnx,fsl-exception = <0x0>;
			xlnx,fsl-links = <0x0>;
			xlnx,i-axi = <0x0>;
			xlnx,i-lmb = <0x1>;
			xlnx,i-lmb-mon = <0x0>;
			xlnx,ic-axi-mon = <0x0>;
			xlnx,icache-always-used = <0x1>;
			xlnx,icache-data-width = <0x0>;
			xlnx,icache-force-tag-lutram = <0x0>;
			xlnx,icache-line-len = <0x8>;
			xlnx,icache-streams = <0x1>;
			xlnx,icache-victims = <0x8>;
			xlnx,ill-opcode-exception = <0x1>;
			xlnx,imprecise-exceptions = <0x0>;
			xlnx,interconnect = <0x2>;
			xlnx,interrupt-is-edge = <0x0>;
			xlnx,interrupt-mon = <0x0>;
			xlnx,ip-axi-mon = <0x0>;
			xlnx,lockstep-select = <0x0>;
			xlnx,lockstep-slave = <0x0>;
			xlnx,mmu-dtlb-size = <0x4>;
			xlnx,mmu-itlb-size = <0x2>;
			xlnx,mmu-privileged-instr = <0x0>;
			xlnx,mmu-tlb-access = <0x3>;
			xlnx,mmu-zones = <0x2>;
			xlnx,num-sync-ff-clk = <0x2>;
			xlnx,num-sync-ff-clk-debug = <0x2>;
			xlnx,num-sync-ff-clk-irq = <0x1>;
			xlnx,num-sync-ff-dbg-clk = <0x1>;
			xlnx,number-of-pc-brk = <0x1>;
			xlnx,number-of-rd-addr-brk = <0x0>;
			xlnx,number-of-wr-addr-brk = <0x0>;
			xlnx,opcode-0x0-illegal = <0x1>;
			xlnx,optimization = <0x0>;
			xlnx,pc-width = <0x20>;
			xlnx,pvr = <0x2>;
			xlnx,pvr-user1 = <0x00>;
			xlnx,pvr-user2 = <0x00000000>;
			xlnx,reset-msr = <0x00000000>;
			xlnx,sco = <0x0>;
			xlnx,trace = <0x0>;
			xlnx,unaligned-exceptions = <0x1>;
			xlnx,use-barrel = <0x1>;
			xlnx,use-branch-target-cache = <0x0>;
			xlnx,use-config-reset = <0x0>;
			xlnx,use-dcache = <0x1>;
			xlnx,use-div = <0x1>;
			xlnx,use-ext-brk = <0x0>;
			xlnx,use-ext-nm-brk = <0x0>;
			xlnx,use-extended-fsl-instr = <0x0>;
			xlnx,use-fpu = <0x0>;
			xlnx,use-hw-mul = <0x2>;
			xlnx,use-icache = <0x1>;
			xlnx,use-interrupt = <0x2>;
			xlnx,use-mmu = <0x3>;
			xlnx,use-msr-instr = <0x1>;
			xlnx,use-pcmp-instr = <0x1>;
			xlnx,use-reorder-instr = <0x1>;
			xlnx,use-stack-protection = <0x0>;
		};
	};
	clocks {
		#address-cells = <1>;
		#size-cells = <0>;
		clk_cpu: clk_cpu@0 {
			#clock-cells = <0>;
			clock-frequency = <83250000>;
			clock-output-names = "clk_cpu";
			compatible = "fixed-clock";
			reg = <0>;
		};
		clk_bus_0: clk_bus_0@1 {
			#clock-cells = <0>;
			clock-frequency = <83250000>;
			clock-output-names = "clk_bus_0";
			compatible = "fixed-clock";
			reg = <1>;
		};
	};
	amba_pl: amba_pl {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		ranges ;
		axi_ethernetlite_0: ethernet@40e00000 {
			compatible = "xlnx,xps-ethernetlite-1.00.a";
			device_type = "network";
			interrupt-parent = <&microblaze_0_axi_intc>;
			interrupts = <2 0>;
			reg = <0x40e00000 0x10000>;
			xlnx,duplex = <0x1>;
			xlnx,include-global-buffers = <0x1>;
			xlnx,include-internal-loopback = <0x1>;
			xlnx,include-mdio = <0x1>;
			xlnx,rx-ping-pong = <0x1>;
			xlnx,s-axi-id-width = <0x1>;
			xlnx,tx-ping-pong = <0x1>;
			xlnx,use-internal = <0x0>;
			phy-handle = <&phy0>;
			axi_ethernetlite_0_mdio: mdio {
				#address-cells = <1>;
				#size-cells = <0>;
				phy0: phy@0 {
					device_type = "ethernet-phy";
					reg = <1>;
				};
			};
		};
		axi_quad_spi_0: axi_quad_spi@44a00000 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "xlnx,xps-spi-2.00.a";
			interrupt-parent = <&microblaze_0_axi_intc>;
			interrupts = <3 0>;
			reg = <0x44a00000 0x10000>;
			xlnx,num-ss-bits = <0x1>;
			axi_flash_spi_0: n25q128@0 {
				#address-cells = <1>;
				#size-cells = <0>;
				compatible = "micron,n25q128a", "jedec,spi-nor";
				reg = <0>; /* Chip select 0 */
				spi-max-frequency = <100000000>;
				xlnx,num-ss-bits = <0x1>;

				partitions {
					compatible = "fixed-partitions";
					#address-cells = <1>;
					#size-cells = <1>;

					partition@bitfile {
						label = "bitfile";
						reg = <0x000000 0x200000>;
					};
					partition@kernel {
						label = "kernel";
						reg = <0x200000 0x500000>;
					};
					partition@rootfs {
						label = "rootfs";
						reg = <0x700000 0x700000>;
					};
					partition@persistent {
						label = "persistent";
						reg = <0xe00000 0x200000>;
					};
					partition@full-image {
						label = "full-image";
						reg = <0x000000 0xE00000>;
					};
					partition@full-disk {
						label = "full-disk";
						reg = <0x000000 0x1000000>;
					};
				};
			};
		};

		axi_timer_0: timer@41c00000 {
			clock-frequency = <83250000>;
			clocks = <&clk_bus_0>;
			compatible = "xlnx,xps-timer-1.00.a";
			interrupt-parent = <&microblaze_0_axi_intc>;
			interrupts = <0 2>;
			reg = <0x41c00000 0x10000>;
			xlnx,count-width = <0x20>;
			xlnx,gen0-assert = <0x1>;
			xlnx,gen1-assert = <0x1>;
			xlnx,one-timer-only = <0x0>;
			xlnx,trig0-assert = <0x1>;
			xlnx,trig1-assert = <0x1>;
		};
		axi_timer_1: pwm@41c10000 {
			clock-frequency = <83250000>;
			clocks = <&clk_bus_0>;
			compatible = "xlnx,xps-timer-1.00.a";
			reg = <0x41c10000 0x10000>;
			#pwm-cells = <2>;
			xlnx,pwm-outputs = <1>;
			xlnx,count-width = <0x20>;
			xlnx,gen0-assert = <0x1>;
			xlnx,gen1-assert = <0x1>;
			xlnx,one-timer-only = <0x0>;
			xlnx,trig0-assert = <0x1>;
			xlnx,trig1-assert = <0x1>;
		};
		axi_uartlite_0: serial@40600000 {
			clock-frequency = <83250000>;
			clocks = <&clk_bus_0>;
			compatible = "xlnx,xps-uartlite-1.00.a";
			current-speed = <115200>;
			device_type = "serial";
			interrupt-parent = <&microblaze_0_axi_intc>;
			interrupts = <1 0>;
			port-number = <0>;
			reg = <0x40600000 0x10000>;
			xlnx,baudrate = <0x2580>;
			xlnx,data-bits = <0x8>;
			xlnx,odd-parity = <0x0>;
			xlnx,s-axi-aclk-freq-hz-d = "83.25";
			xlnx,use-parity = <0x0>;
		};
		microblaze_0_axi_intc: interrupt-controller@41200000 {
			#interrupt-cells = <2>;
			compatible = "xlnx,xps-intc-1.00.a";
			interrupt-controller ;
			reg = <0x41200000 0x10000>;
			xlnx,kind-of-intr = <0xfe>;
			xlnx,num-intr-inputs = <0x4>;
		};
	};
};
/ {
	chosen {
		bootargs = "console=ttyUL0,9600 root=/dev/mtdblock2 earlyprintk=serial,ttyS0,9600";
		linux,stdout-path = &axi_uartlite_0;
		stdout-path = &axi_uartlite_0;
	};
	aliases {
		ethernet0 = &axi_ethernetlite_0;
		serial0 = &axi_uartlite_0;
		spi0 = &axi_quad_spi_0;
		flash0 = &axi_flash_spi_0;
	};
	memory {
		device_type = "memory";
		reg = <0x80000000 0x0f800000>;
	};
};
&axi_ethernetlite_0 {
	local-mac-address = [00 0a 35 00 00 00];
};


-- 
Alvaro G. M.
