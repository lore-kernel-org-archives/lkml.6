Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1345673-1517929812-2-8620563416092850534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517929811; b=mabTZF3LtC4OaRH0mSvnnKLZMZBXtc3oZl7JmUP9d/36p9V
    mLgTGxs9cPCrtrk1uRwByx83l8g+xU8J0MD90D7TVsbZUuxuDZMf2VNxs2XvYLFB
    kiXpnFBKkCPNi2w7wMdfwfeYTdfsCowMJRQv8xizptGCyX+E8bCuo4NCDIJFey87
    QTCyKqcqV/nmE59pZYB+B/V+Vha9vbJvFOgB0hvOBoYdiSJGAgAPYRTLrx6ayiIP
    vCDlpedFjzts9pzgZww8sliFJva1iarACyRCEBniyidRlbE1jC+VH0XNaL9Idtsw
    4XDfn4ENC1E+DhwxGCIh/Y/5KHw713WLSvzS2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517929811; bh=/ywz38KLC1RCOXj7Hju7T7PujpTLmeeQ3i3pQKeOPsk=; b=W
    YOghxkXeIPdFqkDoVWQqwd6ZqezalJE/RhTkPJBCbihzpOfpiXFRmoHhFpjaOfdp
    9WkOoWh08OsKwMo6vHC1+TJgxpaowIN+ux58egEU3baHB6HkN8c67ggEZmXa25ld
    risSIfDTXb2BsZFpJNDUGrDoVtxQNttVAob4RjeL0jCzbUqs7viOvweZNZW/dQaH
    WSHf+PBTcpbUP0sNLKUbZIJCCzYn38uaQkw303kwA/v56kWpqvmPm4FCDZSJv0qO
    8h9DOIAgRzulDvYY5GsZ69ykYks6PpEI8l1Wt/RL86S9pF2Akkg+hZt0tji4uK3c
    Ahude4fmBwI3a5JVFIpxw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=zj6oTDzG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EWUzsKfE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=zj6oTDzG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EWUzsKfE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeBFPJy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 10:09:54 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36867 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeBFPJw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 10:09:52 -0500
X-Google-Smtp-Source: AH8x227+Q/xeraJT4t8kRP58X8VrwIg7ANudDpdNEiRt0MmgjtEl5i6Q+CkF1XubE31ncxoc0G6h2B9pOkbYYmeJXWg=
MIME-Version: 1.0
In-Reply-To: <20180206075337.yzzziohvv6qc6t7y@hz-desktop>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206075337.yzzziohvv6qc6t7y@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Feb 2018 07:09:50 -0800
Message-ID: <CAPcyv4iVcukZSermEk9V=nZtzpZF_ghXzoQVMJJXpO_Vo2_19g@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfio: disable filesystem-dax page pinning
To: Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>, linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 11:53 PM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> Hi Dan,
>
> On 02/04/18 15:05 -0800, Dan Williams wrote:
>> Filesystem-DAX is incompatible with 'longterm' page pinning. Without
>> page cache indirection a DAX mapping maps filesystem blocks directly.
>> This means that the filesystem must not modify a file's block map while
>> any page in a mapping is pinned. In order to prevent the situation of
>> userspace holding of filesystem operations indefinitely, disallow
>> 'longterm' Filesystem-DAX mappings.
>>
>> RDMA has the same conflict and the plan there is to add a 'with lease'
>> mechanism to allow the kernel to notify userspace that the mapping is
>> being torn down for block-map maintenance. Perhaps something similar can
>> be put in place for vfio.
>>
>> Note that xfs and ext4 still report:
>>
>>    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"
>>
>> ...at mount time, and resolving the dax-dma-vs-truncate problem is one
>> of the last hurdles to remove that designation.
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: kvm@vger.kernel.org
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O"=
)
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_t=
ype1.c
>> index e30e29ae4819..45657e2b1ff7 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struct *mm, uns=
igned long vaddr,
>>  {
>>       struct page *page[1];
>>       struct vm_area_struct *vma;
>> +     struct vm_area_struct *vmas[1];
>>       int ret;
>>
>>       if (mm =3D=3D current->mm) {
>> -             ret =3D get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRIT=
E),
>> -                                       page);
>> +             ret =3D get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_=
WRITE),
>> +                                           page, vmas);
>>       } else {
>>               unsigned int flags =3D 0;
>>
>> @@ -351,7 +352,18 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsi=
gned long vaddr,
>>
>>               down_read(&mm->mmap_sem);
>>               ret =3D get_user_pages_remote(NULL, mm, vaddr, 1, flags, p=
age,
>> -                                         NULL, NULL);
>> +                                         vmas, NULL);
>> +             /*
>> +              * The lifetime of a vaddr_get_pfn() page pin is
>> +              * userspace-controlled. In the fs-dax case this could
>> +              * lead to indefinite stalls in filesystem operations.
>> +              * Disallow attempts to pin fs-dax pages via this
>> +              * interface.
>> +              */
>> +             if (ret > 0 && vma_is_fsdax(vmas[0])) {
>> +                     ret =3D -EOPNOTSUPP;
>> +                     put_page(page[0]);
>> +             }
>>               up_read(&mm->mmap_sem);
>>       }
>>
>>
>
> Besides this patch series, are there other patches needed to make
> vma_is_fsdax() to work with device-dax?
>
> I applied this patch series on the libvdimm-for-next branch of nvdimm
> tree (ee95f4059a83), and found this patch series also failed
> device-dax mapping with vfio. It can be reproduced by following steps:
>
> 1. Attach PCI device at BDF 0000:03:10.2 to vfio-pci.
>    # modprobe vfio-pci
>    # lspci -n -s 0000:03:10.2
>    03:10.2 0200: 8086:1515 (rev 01)
>    # echo 0000:03:10.2 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
>    # echo 8086:1515 > /sys/bus/pci/drivers/vfio-pci/new_id
>
> 2. Use RAM to emulate NVDIMM and create a device-dax device /dev/dax0.0
>    # cat /proc/iomem
>    ...
>    100000000-2ffffffff : Persistent Memory (legacy)
>      100000000-2ffffffff : namespace0.0
>    ...
>
>    # ndctl create-namespace -f -e namespace0.0 -m dax
>    {
>      "dev":"namespace0.0",
>      "mode":"dax",
>      "size":8453619712,
>      "uuid":"e1db00bc-f830-4f1b-ac18-091ae7df4f93",
>      "daxdevs":[
>        {
>          "chardev":"dax0.0",
>          "size":8453619712
>        }
>      ]
>    }
>
> 3. Create a VM with assigned PCI device in step 1 and the device-dax
>    device in step 2.
>    # qemu-system-x86_64 -machine pc,accel=3Dkvm,nvdimm=3Don -smp host \
>                         -m 4G,slots=3D32,maxmem=3D128G \
>                         -drive file=3DVM_DISK_IMG.img,format=3Draw,if=3Dv=
irtio \
>                         -object memory-backend-file,id=3Dnv_be1,share=3Do=
n,mem-path=3D/dev/dax0.0,size=3D4G,align=3D2M \
>                         -device nvdimm,id=3Dnv1,memdev=3Dnv_be1 \
>                         -device ioh3420,id=3Droot.0,slot=3D4 \
>                         -device vfio-pci,sysfsdev=3D/sys/bus/pci/devices/=
0000:03:10.2,id=3Dnic1,bus=3Dpci.0,addr=3D0x6
>
>    It then fails with the following QEMU error messages:
>      qemu-system-x86_64: -device vfio-pci,sysfsdev=3D/sys/bus/pci/devices=
/0000:03:10.2,id=3Dnic1,bus=3Dpci.0,addr=3D0x6: VFIO_MAP_DMA: -95
>      qemu-system-x86_64: -device vfio-pci,sysfsdev=3D/sys/bus/pci/devices=
/0000:03:10.2,id=3Dnic1,bus=3Dpci.0,addr=3D0x6: vfio_dma_map(0x5643804a92c0=
, 0x140000000, 0xffe00000, 0x7f2ed5200000) =3D -95 (Operation not supported=
)
>      qemu-system-x86_64: -device vfio-pci,sysfsdev=3D/sys/bus/pci/devices=
/0000:03:10.2,id=3Dnic1,bus=3Dpci.0,addr=3D0x6: vfio error: 0000:03:10.2: f=
ailed to setup container for group 52: memory listener initialization faile=
d for container: Operation not supported
>
>    I added the following debug messages after the
>    get_user_pages_longterm() call in this patch,
>        if (vmas[0] && vma_is_dax(vmas[0]))
>                printk(KERN_DEBUG "%s: longterm failed for pfn 0x%lx, ret =
%d\n",
>                       __func__, page_to_pfn(page[0]), ret);
>    and shows get_user_pages_longterm() returns -EOPNOTSUPP on the
>    first device-dax page mapping.

Thanks for that thorough debug, I'll take a look today.
