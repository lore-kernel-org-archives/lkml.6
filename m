Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519390496; cv=none;
        d=google.com; s=arc-20160816;
        b=A2y71Ek7bY1AwwZUVL7rCwTJmrn1YIs4oiARYETgGVBmdlCyGSzOrIf1pY5GhNZl20
         og+0seSiDLQ3caWJOh3XI5KjqQ+fjpkTM3r4WYqZSMVnnbvuEHNZD8+ATsUmZriKflyk
         emvYYzFfGRXcQgUHIr/VsXshjiGiOPAAlBXuWyj1u+z/rHgSVE033mNd7T3gTKeH3iXp
         3P+4K2vptlCVTeZAj13+J2d1LZhBIVjQYgFdaPQ/fbTfXVwh3HLRiKzobeYRq0lofitk
         bgQBIS9GxZNWtivZN7pdiXS5Lz9+mn38Ga321mVgFT6R22NnJzBwldI3QkeO+G387WtD
         Ww9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=aZUDLgmM3F8h8ycVRF3MxdaBKUOHKuI+KS/+6UcRmLQ=;
        b=CULsoOJWwKMNu+SEGKtK0m/AT14CGCgmi9euxA2ChTGeoAgG7t60LrJU3QuzMa5RB1
         8Fm7qifceEpFEkmCpzKKT/V8o5uqD9gyqY1ls6o5/AaHaCknb4rBbulpv/1Sfpu0xJwb
         wplR8EZSuKK79UlumeXFRGXDzlj21k1wXvS6jsFjw1w8XprBs9pKRE0gjDaRcmCutj24
         n2HugUBSgLw5MnJ5UgB7SOQ7ZIG8rsomtJx5NtG/OKbpdWjVZixTGOzCxIv95d9YNyMe
         9O6z3G6IwpTOhsSJmbZZ5eNpKd21WWVQSpSbfbGGN9CIjnsoxTEn7E63oZdqueCaLtsK
         BAig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tlbxBMLp;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tlbxBMLp;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225bRPElxHzRuN4Ee7QyZAJGt5t3fvudGf7jAeCPPQLe7VU3W4+EXuB3AOncevzDxjlLl6jqIQ==
Date: Fri, 23 Feb 2018 18:24:48 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2] acpi: nfit: document sysfs interface
Message-ID: <20180223125448.GA16909@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593196408980037383?=
X-GMAIL-MSGID: =?utf-8?q?1593196408980037383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an attempt to document the nfit sysfs interface. The
descriptions have been collected from git commit logs and the ACPI
specification 6.2.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Add descriptions for range_index and ecc_unit_size
- Edit various descriptions as suggested

 Documentation/ABI/testing/sysfs-bus-nfit | 233 +++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-nfit

diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/testing/sysfs-bus-nfit
new file mode 100644
index 000000000000..619eb8ca0f99
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -0,0 +1,233 @@
+For all of the nmem device attributes under nfit/*, see the 'NVDIMM Firmware
+Interface Table (NFIT)' section in the ACPI specification
+(http://www.uefi.org/specifications) for more details.
+
+What:		/sys/bus/nd/devices/nmemX/nfit/serial
+Date:		Jun, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Serial number of the NVDIMM (non-volatile dual in-line
+		memory module), assigned by the module vendor.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/handle
+Date:		Apr, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) The address (given by the _ADR object) of the device on its
+		parent bus of the NVDIMM device containing the NVDIMM region.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/device
+Date:		Apr, 2015
+KernelVersion:	v4.1
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Device id for the NVDIMM, assigned by the module vendor.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/rev_id
+Date:		Jun, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Revision of the NVDIMM, assigned by the module vendor.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/phys_id
+Date:		Apr, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Handle (i.e., instance number) for the SMBIOS (system
+		management BIOS) Memory Device structure describing the NVDIMM
+		containing the NVDIMM region.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/flags
+Date:		Jun, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) The flags in the NFIT memory device sub-structure indicate
+		the state of the data on the nvdimm relative to its energy
+		source or last "flush to persistence".
+
+		The attribute is a translation of the 'NVDIMM State Flags' field
+		in section 5.2.25.3 'NVDIMM Region Mapping' Structure of the
+		ACPI specification 6.2.
+
+		The health states are "save_fail", "restore_fail", "flush_fail",
+		"not_armed", "smart_event", "map_fail" and "smart_notify".
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/format
+What:		/sys/bus/nd/devices/nmemX/nfit/format1
+What:		/sys/bus/nd/devices/nmemX/nfit/formats
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) The interface codes indicate support for persistent memory
+		mapped directly into system physical address space and / or a
+		block aperture access mechanism to the NVDIMM media.
+		The 'formats' attribute displays the number of supported
+		interfaces.
+
+		This layout is compatible with existing libndctl binaries that
+		only expect one code per-dimm as they will ignore
+		nmemX/nfit/formats and nmemX/nfit/formatN.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/vendor
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Vendor id of the NVDIMM.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/dsm_mask
+Date:		May, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) The bitmask indicates the supported device specific control
+		functions relative to the NVDIMM command family supported by the
+		device
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/family
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Displays the NVDIMM family command sets. Values
+		0, 1, 2 and 3 correspond to NVDIMM_FAMILY_INTEL,
+		NVDIMM_FAMILY_HPE1, NVDIMM_FAMILY_HPE2 and NVDIMM_FAMILY_MSFT
+		respectively.
+
+		See the specifications for these command families here:
+		http://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf
+		https://github.com/HewlettPackard/hpe-nvm/blob/master/Documentation/
+		https://msdn.microsoft.com/library/windows/hardware/mt604741"
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/id
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) ACPI specification 6.2 section 5.2.25.9, defines an
+		identifier for an NVDIMM, which refelects the id attribute.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_vendor
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Sub-system vendor id of the NVDIMM non-volatile memory
+		subsystem controller.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_rev_id
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Sub-system revision id of the NVDIMM non-volatile memory subsystem
+		controller, assigned by the non-volatile memory subsystem
+		controller vendor.
+
+
+What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_device
+Date:		Apr, 2016
+KernelVersion:	v4.7
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Sub-system device id for the NVDIMM non-volatile memory
+		subsystem controller, assigned by the non-volatile memory
+		subsystem controller vendor.
+
+
+What:		/sys/bus/nd/devices/ndbusX/nfit/revision
+Date:		Jun, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) ACPI NFIT table revision number.
+
+
+What:		/sys/bus/nd/devices/ndbusX/nfit/scrub
+Date:		Sep, 2016
+KernelVersion:	v4.9
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RW) This shows the number of full Address Range Scrubs (ARS)
+		that have been completed since driver load time. Userspace can
+		wait on this using select/poll etc. A '+' at the end indicates
+		an ARS is in progress
+
+		Writing a value of 1 triggers an ARS scan.
+
+
+What:		/sys/bus/nd/devices/ndbusX/nfit/hw_error_scrub
+Date:		Sep, 2016
+KernelVersion:	v4.9
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RW) Provides a way to toggle the behavior between just adding
+		the address (cache line) where the MCE happened to the poison
+		list and doing a full scrub. The former (selective insertion of
+		the address) is done unconditionally.
+
+		This attribute can have the following values written to it:
+
+		'0': Switch to the default mode where an exception will only
+		insert the address of the memory error into the poison and
+		badblocks lists.
+		'1': Enable a full scrub to happen if an exception for a memory
+		error is received.
+
+
+What:		/sys/bus/nd/devices/ndbusX/nfit/dsm_mask
+Date:		Jun, 2017
+KernelVersion:	v4.13
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) The bitmask indicates the supported bus specific control
+		functions. See the section named 'NVDIMM Root Device _DSMs' in
+		the ACPI specification.
+
+
+What:		/sys/bus/nd/devices/regionX/nfit/range_index
+Date:		Jun, 2015
+KernelVersion:	v4.2
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) A unique number provided by the BIOS to identify an address
+		range. Used by NVDIMM Region Mapping Structure to uniquely refer
+		to this structure. Value of 0 is reserved and not used as an
+		index.
+
+
+What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
+Date:		Aug, 2017
+KernelVersion:	v4.14
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Size of a write request to a DIMM that will not incur a
+		read-modify-write cycle at the memory controller.
+
+		When the nfit driver initializes it runs an ARS (Address Range
+		Scrub) operation across every pmem range. Part of that process
+		involves determining the ARS capabilities of a given address
+		range. One of the capabilities that is reported is the 'Clear
+		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
+		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
+		This property indicates the boundary at which the NVDIMM may
+		need to perform read-modify-write cycles to maintain ECC (Error
+		Correcting Code) blocks.
-- 
2.16.2
