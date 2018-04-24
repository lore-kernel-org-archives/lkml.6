Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDXPbR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:31:17 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:21760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751683AbeDXPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:31:01 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>
Subject: Avoid uninterruptible sleep during process exit
Date: Tue, 24 Apr 2018 11:30:33 -0400
Message-ID: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(39380400002)(2980300002)(428003)(199004)(189003)(476003)(36756003)(97736004)(105586002)(106466001)(6666003)(316002)(48376002)(26005)(54906003)(110136005)(50466002)(50226002)(44832011)(7696005)(86362001)(51416003)(104016004)(53416004)(16586007)(2906002)(68736007)(8936002)(81166006)(336012)(486006)(126002)(72206003)(47776003)(81156014)(8676002)(356003)(77096007)(186003)(4326008)(426003)(305945005)(5660300001)(53936002)(478600001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0754;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT004;1:kCmRTXS/JPbONMnFSRLg7cFI7nFlUmj5VJpQEbn49VcSSixGZsHcdY/6oBQolFpZ1b8YCk8DTyK0zeqq5gSAlKpgvz29kWC4yBEhoLdu3W+cEjB1e2RkatIPmb+i/0rq
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;3:c0g9SPZ7ttcOwZnbL4e4mUsuKvPHFX9xSLBSt1A7fsnLSk3u2J8WAZ5FTjEP7rutq4EPgf+5UJvq1UyaH6fAY5saz1pIdF8swmD0JoPOt6vQ1e3GIxT4jk6HjXaGobrdKSddEFkQh/Z7qzwx3r7PZlk1h1iYDquV9O3cB3oJ8FuuA8WBxbW/1j3cEJpHhsnEf/rvL2eWQhYD8//zj6/2UcW6zin07cv2UdYVWGnHC+F+qe/amXkwGJBlLyOK1AitjdmXpJ7EsK+RRQ7o9MW+elO111WeW8yCkREy83nL6dG/IQKkku71thxQMUELbBUb+/kfRqPoAAYmWraVw1NToBKvecM2gEmwRWKl2DtrjHg=;25:K5jatr+uQvQx9Scc1+DVXjORKjUaNPX/z0k8Sj82Jtqh79P0u5RhrWiK347zri6e7EznrdVsu7DklJRXGvyOEKgAfJ4clTdOC3Z0j3+7QYHGezh9ALAo2OXw2icpoZOlfItdI3st5cUHRc74lWVM2/rj983a9STHsKa3OXHrD+kYnxrAmW2cZCl1A+KTT04gTd3HkPkYzlFnwWo1uYpR6VEktPEiI8IwbAB+Nck83x/iFH8vba5YBOcEtM25rwdtftp3g7lY+tr8njE19V9v8Gc05ykZbtYHnP38RVumK8BhZfsdxwcwAbjxTUX4R2jbP+8DTZQtTVPML1XUYHgghA==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0754:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;31:55AjtocDH85K9SVy/SSZlKAKxNOCzwWj6wbbRjiebYHaQ1u/BV5bJr6BPCY/xjmeRXNAQA/q2YOhLZxhw8yIw5QoZ2zB+GUuPN6BjQ7go929ZF1g7n7ltOOwhF0Xx61AUouX7SFw0Hg1DXgCTgr3WKnXSWsZNFV6dRuJa1nSGNVL0Aco1lfeNI7eyc1YUTr5XxRCeHAJUqnCV0sn54/9MQt4jt4sGiC6wvHf+FiQx4Y=;20:Jy3/iYPLmsACtlg0DHbEGO4ozzjtVWzW5rxgrFuU9ht2G5kTficXuEVVq2MkUcmVFOYPM3VJZ5aRl3E7eIxXiheR627pk+djy3rOVxCT8H9jLLDEc7rma3H+zgQA/c53CDMGRiRxGzHmG1LtZDC7iTb8RXsxCUMpS830PfJmIbBpnu76Ue03hZELgo+gCHLDATaoN2NT4U5gU7Ni0/+UAnvtrc/++ZmtUESF5kT48ZSWfLiMBJBTrdT/m18AxF2TFvRzFO6Ig/RtJxR40eL2Ex85OSNeWyKLwJt8DLAqDsUX+Wi55tl0kd/6f18StfKbe+TlGdClhgR0yrM8/+GOngd+Gex8zFG36BrRVv9PMss5C7oXh6bn8iFd/ltjDNwv8B2C8Ug1+FhRZWT46QjB5Xu26+cla/tFooKW+XUWEjZbWDEKzE9JB+JL0M8iKrzlJf5eVVFc6V6XZ/Sna8UVNsa3xJwbS21994p4bV+W/visBQTOzuIfkKjg/oTISPmO
X-Microsoft-Antispam-PRVS: <BN4PR12MB0754671D17CF594FD83DFE40EA880@BN4PR12MB0754.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN4PR12MB0754;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;4:vnKpePfiguRW3eZ/CeqitfS+zwnRRw0H3NaIp4KHksVXsMhxgYDimwvFWVuBKPYtvPXPdMm4sjjCGv6tyWCl+GExg7uQGnMzO0YMjWdcx/E/w64C+0rvIleCySx90sPBXAVoBEN/yA4s0S+CkZmPjvsTRW5jhCv4Woxyt/hji83ZDzZ2HEGV17/D3z7ikJ5ivGiy+bkq8GbVSPhw4wICktQA2XXn3pjeqcptLT13FcDQ1W52Rct9yGP+ovkmkKPcDJ21NZTjgzt6CKeGvv/jhfFMS8Sqp+U2d0HIlpkUFVL7ZqzAWn74KBPA/IYGX1vk
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0754;23:m611mQ0wXpgIDYWShJeFKA4S61SdbZ9DU3eNX0xlz?=
 =?us-ascii?Q?WRRwkMEw5nEcBURffAZYcK2+6j77QwazMUNRxzphM/WsuNBc4XEkPoo9rQEy?=
 =?us-ascii?Q?LCi4YX5LYZ+wPM61r7pyZhifEYafEqHlJNQQbTrRRAjBv/aJZ56zDwMOAlHy?=
 =?us-ascii?Q?z9awYirXsWSnrBkQKwLevYjmurFO0soKFdORQ/UHKLuyFMfu+dgO0Z9IYE/+?=
 =?us-ascii?Q?yjR/opLps8LAk8ESM9KG0AP6KYhYgKyyxEmncmwOMC1oGupjobDdONKei1BA?=
 =?us-ascii?Q?W36I/M21agI60No0uD/uvbXqIRBrThDjHujEkBYZ5ylE4fZepXa7VHhJiFuW?=
 =?us-ascii?Q?YHgAIY+IQswJOHq//jDsYU3lsUFBCmOdPN5rashHtiWcdAxZ66jCsFyQrFWp?=
 =?us-ascii?Q?BV4viw7fDVX+/m2cYw1teocdmEqoRmI2Z1Tw/DMqr/yQDIa5kupEV3KnvQ2N?=
 =?us-ascii?Q?e6E3764EvoQMEHJ7Q0s6IIMo/VNCmVnk15sedIJkw5FQ4B8LFAmH+X1Gd1+z?=
 =?us-ascii?Q?E/vWKkLoJqHkj1eiQQVXesmhjtjfNEyHhECLV7KPLLT9Tk0Qnox4uRDRp87Q?=
 =?us-ascii?Q?xu8J3D3hHiXGghPe3TNc9PWJdjrbsqpeRPDTKmfnekorCFArd/Pjrvc6ibCx?=
 =?us-ascii?Q?LsZVTCo2F+JbVP8GNhscNYIoeVEpSLtgZXHmPH8CLFL9v5NJByVYmKxcAF6L?=
 =?us-ascii?Q?dqN7F34DLhPZGo3te8cBvKm+cj4OuRvmdandxvFN7QiMW26CeR00vY8YoG05?=
 =?us-ascii?Q?EdHiXp75n9ntICtwnzfWiBY4wmYXb4VZtnwA/f8XnziV378f/YBoIk8UmvR4?=
 =?us-ascii?Q?uwxYMDTkbHvflNsBYBwaaQCGlLp8V+nVMRkwFt7eKax0CkOb3+/dBhGYysAz?=
 =?us-ascii?Q?xxGIgvT3BdqHsTXPWmN42Zk9/VNF5EAckqxkGZjNkpEOa+SMFM/3/xb4LV+7?=
 =?us-ascii?Q?/Xe+vNXmb6qaFZGPKcb6kD55gDLGYyy1G9KtujU27xQbU/tzF0hmEds1l/Lk?=
 =?us-ascii?Q?SyTfpxKzfiZnLfhsMnNYEIsKDmJLyPEQ0VMCkbYSUw9q6a8RHWJ/PCgYgcaB?=
 =?us-ascii?Q?58yNQJ/UAe5ZAH5fjs417dSiM3w9TSOjPUnE51B1GnXaXNPsC/HkFq/GTY5y?=
 =?us-ascii?Q?87z7OlQuc52GtU3+UcdUa5gETm9Jl+T?=
X-Microsoft-Antispam-Message-Info: xVz7auvsQy09nfABBSGjBJinuaZZXPgjLSKHlNsNHApPV+Nm3kC91b5oTNKfwRYu6oyiQKwpLQOG3C6DVkFT//vQJWjgAInQln5LCcEp0nEUSYQ6PN0XXvWTD3WLDG6qbPjIqliu5ZkP4sxyObcMnqlPAGgYSng24SLxaMz83rPXifxPUZIaaJvOcVOVQLsZ
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;6:IEMcZFA0b5Ls0XVCqRG9QbbKLSESt7WlUyH8F+p+UhFZHvzeAVWMfoNImPgaxay3VL7AgTR5PyRvYZg1cwdGiRuOAKqx+ywTT8yHXVuAz4GezvIrQeA4g1fXQDIZJwNF7S1QcbOHIkrihZ/nByDCFVrlHZ3dzdZm7U7ZqyuZD8Xb1gd9TQoGHlVgwAuxaKcMi7xzIpghu8xXs0J0ZTsIJ7UWNTBMZ7ANji+XcQdXVZPOc+SEVOV//Z6fBUbXkS/80BeciVpOXc3cYg3wGVpO5sOUU9FmGUDs9oQbh1KfQXeoactnHcYcrgwPicdSxFdzUmlUwUQPzMtOdNQIAOWsxtBhOwe3/tUAexlx2AfuZhMmI6AMSWr1EPzN9kag8IVgWsryeYZ0Jyo0HkdFLbxOpyR3dJMnYOBAWoQEp3FEGc6iN8iNDD/0yY3dYxbTn9c0qVQLN94GsKUkaC1/M/LK0w==;5:IjKewvf5bsssG0+TXaelaAkGxNt0YUYlXPLk2iVngPJFpNY7Nfqo3JmBs32+jLhVjnNzYPsRH8SMAIzqs47bkul4pB2T6u5HXO9uXWWeRgtJFLVSPMiTELnJIb/gvRZ8bUa0ou5kbqpV17XcqZnm3M1eNJudQ8eoKIF7Y4f6oWI=;24:WfW/AEClQHPc7I/t+qX6U6UmWnVoUBmlIeCjrpswmCUhyaorD0lS4nbS2AMRUvMWV4YvHIdMtvdEC2RM8LQfdDklMa/7yneeCcIIfVA5gTo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;7:dBM0sUX+vEvE+CswZ6ki1EKHUt3Q0bT18jgiPY37ihCE2Zl7utsNsHflelErCUgOFUw2uBog8wax5bi9qiHAm35uGgbi6U2HAJohplGQiK6rYVPWSBSIK15bfRGHNtjCX7YmT2gwpA3g1RUG2o2+NWHpOCWB54t46L+fdUCXmr3pkB7ldQjad9IhOc1zL89EokMTYjiLA0j0E0StlwCCvy6ow3TlbGfo5HbD/d9vU5PSXfSfwx/fAxqA5kFvSy54;20:khnHMC7ZbJgvWVcViKKUiuTR4O+QY4yxl28+5AcJYb0hbsaR1wYH19JYkjuqMl/2hgHbKgXIRJThN94DppgoGB8gbvx238HtE3d8WuA/1PfL3F0dAZMclUcsROWS+j5J8/sT11CLZ0Jq/yr9Q489RxPckOpnfIIHJA1C+8yEd4HoQN0Y2m15QyUB45ubHt7i9/PGtqiR035JLFUu+SjPX4tg16TIbisvUnPWJYYDk7zvzmgT/DiQOpy7WpFIxi/F
X-MS-Office365-Filtering-Correlation-Id: 4c5c7be7-f3b8-4537-15ca-08d5a9f860cb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:30:58.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5c7be7-f3b8-4537-15ca-08d5a9f860cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0754
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following 3 patches address an issue we encounter in AMDGPU driver.

When GPU pipe is stalling for some reason (shader code error, incorrectly programmed registers e.t.c...) 
uninterruptible wait in kernel puts the user process in unresponsive state 
which only can be remedied by  system's hard reset.   

Each patch addresses a different use case of such problem.

First one is normal exit (not from signal processing) the change in 
core/signal.c - to allow propagation of KILL signal to process marked as exiting.

Second one is exit due to death because of unhanded  signal during signal 
processing - to avoid waiting for SIGKILL if you are called from
...->do_signal->get_signal->do_group_exit->do_exit->...->wait_event_killable

Third one is nor related to process exit and just avoids uninterruptible wait 
for particular job completion on the GPU pipe.

P.S Sending this to the kernel mailing list mainly because of the first patch, 
the 2 others are intended more for amd-gfx@lists.freedesktop.org and 
are given here just to provide more context for the problem we try to solve.

Andrey Grodzovsky (3):

signals: Allow generation of SIGKILL to exiting task.   
drm/scheduler: Don't call wait_event_killable for signaled process.   
drm/amdgpu: Switch to interrupted wait to recover from ring hang.

drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 14 ++++++++++----
drivers/gpu/drm/scheduler/gpu_scheduler.c |  5 +++--
kernel/signal.c                           |  4 ++--
3 files changed, 15 insertions(+), 8 deletions(-)
