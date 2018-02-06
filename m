Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-440661-1517903626-2-15190330879733300628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517903625; b=OUkQnBEuwCSnDCqevdQj7wr9fK9O3I05OA6rj99ybyiDCtB
    RL2ohmC62dJ+Kh4AYZz/22v1pRBzetTT2THm+uB88SI7PN3VKWjbrzbSzDmNfcJS
    OyII28d9a7wT23xehiGJrXqb2hFPRbFRMBZG8j5Zkleu3tfuJ0gW41G7UtBCNUth
    bZPk4DfD3lOJV86Sf4Is6Tx7X/7V63y2nZXUoOl8kkPYqLLDCioPETWkWqvUqzan
    hZ5XY/yDRM3fIZFnZpDlj5ltd5SPRQDEgR56qJsZuARWUKdxd4ie7ySpszVmzSD7
    S7Q1EzOxxWqoQUe/eiqNm3zMYmXpCrNkfqL7k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517903625; bh=avi8pXa2CI9Q+AqSocSSudhyh1
    Km8msTTTkL1BDMpGo=; b=LDPNBg5aPRfLkPAcuhkdSaE88r+XRjYth/RTyhwSKK
    ZegysKC5AdZwfhW5eTeNVgy+NStcNM8ORUehmeRSWMyWDjw9MLaaMFUuPHE1iMSs
    dG/yoDo7+BqzcqCekb/iWl4tiuLN1TLlQls5KCWQXLUD9JKIO2mWb9EKF2XPH3Ep
    OtS9CxdJw37fAmwo4SO37Co3S/LZ4wqxLDeS+Wo74jWWSxK51V9w2zu2UViQvh4f
    EjDk/q8+cc+oOE8Z0J08EHTwDYlnFkZsuEDgA3UfYilGP6vkFXEPSRc+ic1iYYGB
    1tK+phEncOZyZmJmA5LyDqzbgXwg0fmOkP0ewvA5aGBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeBFHxn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 02:53:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:7380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751924AbeBFHxl (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 02:53:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="201708412"
Date: Tue, 6 Feb 2018 15:53:37 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: alex.williamson@redhat.com, Michal Hocko <mhocko@suse.com>,
        jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 3/3] vfio: disable filesystem-dax page pinning
Message-ID: <20180206075337.yzzziohvv6qc6t7y@hz-desktop>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        alex.williamson@redhat.com, Michal Hocko <mhocko@suse.com>,
        jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20171027
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On 02/04/18 15:05 -0800, Dan Williams wrote:
> Filesystem-DAX is incompatible with 'longterm' page pinning. Without
> page cache indirection a DAX mapping maps filesystem blocks directly.
> This means that the filesystem must not modify a file's block map while
> any page in a mapping is pinned. In order to prevent the situation of
> userspace holding of filesystem operations indefinitely, disallow
> 'longterm' Filesystem-DAX mappings.
> 
> RDMA has the same conflict and the plan there is to add a 'with lease'
> mechanism to allow the kernel to notify userspace that the mapping is
> being torn down for block-map maintenance. Perhaps something similar can
> be put in place for vfio.
> 
> Note that xfs and ext4 still report:
> 
>    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"
> 
> ...at mount time, and resolving the dax-dma-vs-truncate problem is one
> of the last hurdles to remove that designation.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e30e29ae4819..45657e2b1ff7 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  {
>  	struct page *page[1];
>  	struct vm_area_struct *vma;
> +	struct vm_area_struct *vmas[1];
>  	int ret;
>  
>  	if (mm == current->mm) {
> -		ret = get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRITE),
> -					  page);
> +		ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
> +					      page, vmas);
>  	} else {
>  		unsigned int flags = 0;
>  
> @@ -351,7 +352,18 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  
>  		down_read(&mm->mmap_sem);
>  		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
> -					    NULL, NULL);
> +					    vmas, NULL);
> +		/*
> +		 * The lifetime of a vaddr_get_pfn() page pin is
> +		 * userspace-controlled. In the fs-dax case this could
> +		 * lead to indefinite stalls in filesystem operations.
> +		 * Disallow attempts to pin fs-dax pages via this
> +		 * interface.
> +		 */
> +		if (ret > 0 && vma_is_fsdax(vmas[0])) {
> +			ret = -EOPNOTSUPP;
> +			put_page(page[0]);
> +		}
>  		up_read(&mm->mmap_sem);
>  	}
>  
> 

Besides this patch series, are there other patches needed to make
vma_is_fsdax() to work with device-dax?

I applied this patch series on the libvdimm-for-next branch of nvdimm
tree (ee95f4059a83), and found this patch series also failed
device-dax mapping with vfio. It can be reproduced by following steps:

1. Attach PCI device at BDF 0000:03:10.2 to vfio-pci.
   # modprobe vfio-pci
   # lspci -n -s 0000:03:10.2
   03:10.2 0200: 8086:1515 (rev 01)
   # echo 0000:03:10.2 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
   # echo 8086:1515 > /sys/bus/pci/drivers/vfio-pci/new_id

2. Use RAM to emulate NVDIMM and create a device-dax device /dev/dax0.0
   # cat /proc/iomem
   ...
   100000000-2ffffffff : Persistent Memory (legacy)
     100000000-2ffffffff : namespace0.0
   ...

   # ndctl create-namespace -f -e namespace0.0 -m dax
   {
     "dev":"namespace0.0",
     "mode":"dax",
     "size":8453619712,
     "uuid":"e1db00bc-f830-4f1b-ac18-091ae7df4f93",
     "daxdevs":[
       {
         "chardev":"dax0.0",
         "size":8453619712
       }
     ]
   }

3. Create a VM with assigned PCI device in step 1 and the device-dax
   device in step 2.
   # qemu-system-x86_64 -machine pc,accel=kvm,nvdimm=on -smp host \
                        -m 4G,slots=32,maxmem=128G \
                        -drive file=VM_DISK_IMG.img,format=raw,if=virtio \
                        -object memory-backend-file,id=nv_be1,share=on,mem-path=/dev/dax0.0,size=4G,align=2M \
                        -device nvdimm,id=nv1,memdev=nv_be1 \
                        -device ioh3420,id=root.0,slot=4 \
                        -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:03:10.2,id=nic1,bus=pci.0,addr=0x6

   It then fails with the following QEMU error messages:
     qemu-system-x86_64: -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:03:10.2,id=nic1,bus=pci.0,addr=0x6: VFIO_MAP_DMA: -95
     qemu-system-x86_64: -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:03:10.2,id=nic1,bus=pci.0,addr=0x6: vfio_dma_map(0x5643804a92c0, 0x140000000, 0xffe00000, 0x7f2ed5200000) = -95 (Operation not supported)
     qemu-system-x86_64: -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:03:10.2,id=nic1,bus=pci.0,addr=0x6: vfio error: 0000:03:10.2: failed to setup container for group 52: memory listener initialization failed for container: Operation not supported

   I added the following debug messages after the
   get_user_pages_longterm() call in this patch,
       if (vmas[0] && vma_is_dax(vmas[0]))
               printk(KERN_DEBUG "%s: longterm failed for pfn 0x%lx, ret %d\n",
                      __func__, page_to_pfn(page[0]), ret);
   and shows get_user_pages_longterm() returns -EOPNOTSUPP on the
   first device-dax page mapping.



Haozhong
