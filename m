Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F63208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F63208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeJSEAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:00:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:49688 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbeJSEAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:00:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 12:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="gz'50?scan'50,208,50";a="79828248"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2018 12:57:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gDEQb-0007Dz-C1; Fri, 19 Oct 2018 03:57:53 +0800
Date:   Fri, 19 Oct 2018 03:57:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Yael Chemla <yael.chemla@foss.arm.com>
Cc:     kbuild-all@01.org, Yael CHEmla <yael.chemla@arm.com>,
        linux-kernel@vger.kernel.org,
        Yael Chemla <yael.chemla@foss.arm.com>
Subject: Re: [PATCH 3/3] crypto: ccree: add SM3 support
Message-ID: <201810190321.nOI6wJPW%fengguang.wu@intel.com>
References: <1539867386-20344-4-git-send-email-yael.chemla@foss.arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1539867386-20344-4-git-send-email-yael.chemla@foss.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cryptodev/master]
[also build test ERROR on v4.19-rc8 next-20181018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yael-Chemla/crypto-ccree-add-SM3-support/20181019-033131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-x004-201841 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> drivers/crypto/ccree/cc_hash.c:1729:17: error: 'CC_HW_REV_713' undeclared here (not in a function); did you mean 'CC_HW_REV_712'?
      .min_hw_rev = CC_HW_REV_713,
                    ^~~~~~~~~~~~~
                    CC_HW_REV_712
   drivers/crypto/ccree/cc_hash.c: In function 'cc_init_hash_sram':
>> drivers/crypto/ccree/cc_hash.c:1832:40: warning: comparison between pointer and integer
     bool sm3_supported = (drvdata->hw_rev >= CC_HW_REV_713);
                                           ^~
   drivers/crypto/ccree/cc_hash.c: In function 'cc_hash_alloc':
   drivers/crypto/ccree/cc_hash.c:1975:22: warning: comparison between pointer and integer
     if (drvdata->hw_rev >= CC_HW_REV_713)
                         ^~
   drivers/crypto/ccree/cc_hash.c: In function 'cc_larval_digest_addr':
   drivers/crypto/ccree/cc_hash.c:2252:41: warning: comparison between pointer and integer
     bool sm3_supported = (_drvdata->hw_rev >= CC_HW_REV_713);
                                            ^~

vim +1729 drivers/crypto/ccree/cc_hash.c

  1543	
  1544	#define CC_STATE_SIZE(_x) \
  1545		((_x) + HASH_MAX_LEN_SIZE + CC_MAX_HASH_BLCK_SIZE + (2 * sizeof(u32)))
  1546	
  1547	/* hash descriptors */
  1548	static struct cc_hash_template driver_hash[] = {
  1549		//Asynchronize hash template
  1550		{
  1551			.name = "sha1",
  1552			.driver_name = "sha1-ccree",
  1553			.mac_name = "hmac(sha1)",
  1554			.mac_driver_name = "hmac-sha1-ccree",
  1555			.blocksize = SHA1_BLOCK_SIZE,
  1556			.is_mac = true,
  1557			.synchronize = false,
  1558			.template_ahash = {
  1559				.init = cc_hash_init,
  1560				.update = cc_hash_update,
  1561				.final = cc_hash_final,
  1562				.finup = cc_hash_finup,
  1563				.digest = cc_hash_digest,
  1564				.export = cc_hash_export,
  1565				.import = cc_hash_import,
  1566				.setkey = cc_hash_setkey,
  1567				.halg = {
  1568					.digestsize = SHA1_DIGEST_SIZE,
  1569					.statesize = CC_STATE_SIZE(SHA1_DIGEST_SIZE),
  1570				},
  1571			},
  1572			.hash_mode = DRV_HASH_SHA1,
  1573			.hw_mode = DRV_HASH_HW_SHA1,
  1574			.inter_digestsize = SHA1_DIGEST_SIZE,
  1575			.min_hw_rev = CC_HW_REV_630,
  1576		},
  1577		{
  1578			.name = "sha256",
  1579			.driver_name = "sha256-ccree",
  1580			.mac_name = "hmac(sha256)",
  1581			.mac_driver_name = "hmac-sha256-ccree",
  1582			.blocksize = SHA256_BLOCK_SIZE,
  1583			.is_mac = true,
  1584			.template_ahash = {
  1585				.init = cc_hash_init,
  1586				.update = cc_hash_update,
  1587				.final = cc_hash_final,
  1588				.finup = cc_hash_finup,
  1589				.digest = cc_hash_digest,
  1590				.export = cc_hash_export,
  1591				.import = cc_hash_import,
  1592				.setkey = cc_hash_setkey,
  1593				.halg = {
  1594					.digestsize = SHA256_DIGEST_SIZE,
  1595					.statesize = CC_STATE_SIZE(SHA256_DIGEST_SIZE)
  1596				},
  1597			},
  1598			.hash_mode = DRV_HASH_SHA256,
  1599			.hw_mode = DRV_HASH_HW_SHA256,
  1600			.inter_digestsize = SHA256_DIGEST_SIZE,
  1601			.min_hw_rev = CC_HW_REV_630,
  1602		},
  1603		{
  1604			.name = "sha224",
  1605			.driver_name = "sha224-ccree",
  1606			.mac_name = "hmac(sha224)",
  1607			.mac_driver_name = "hmac-sha224-ccree",
  1608			.blocksize = SHA224_BLOCK_SIZE,
  1609			.is_mac = true,
  1610			.template_ahash = {
  1611				.init = cc_hash_init,
  1612				.update = cc_hash_update,
  1613				.final = cc_hash_final,
  1614				.finup = cc_hash_finup,
  1615				.digest = cc_hash_digest,
  1616				.export = cc_hash_export,
  1617				.import = cc_hash_import,
  1618				.setkey = cc_hash_setkey,
  1619				.halg = {
  1620					.digestsize = SHA224_DIGEST_SIZE,
  1621					.statesize = CC_STATE_SIZE(SHA224_DIGEST_SIZE),
  1622				},
  1623			},
  1624			.hash_mode = DRV_HASH_SHA224,
  1625			.hw_mode = DRV_HASH_HW_SHA256,
  1626			.inter_digestsize = SHA256_DIGEST_SIZE,
  1627			.min_hw_rev = CC_HW_REV_630,
  1628		},
  1629		{
  1630			.name = "sha384",
  1631			.driver_name = "sha384-ccree",
  1632			.mac_name = "hmac(sha384)",
  1633			.mac_driver_name = "hmac-sha384-ccree",
  1634			.blocksize = SHA384_BLOCK_SIZE,
  1635			.is_mac = true,
  1636			.template_ahash = {
  1637				.init = cc_hash_init,
  1638				.update = cc_hash_update,
  1639				.final = cc_hash_final,
  1640				.finup = cc_hash_finup,
  1641				.digest = cc_hash_digest,
  1642				.export = cc_hash_export,
  1643				.import = cc_hash_import,
  1644				.setkey = cc_hash_setkey,
  1645				.halg = {
  1646					.digestsize = SHA384_DIGEST_SIZE,
  1647					.statesize = CC_STATE_SIZE(SHA384_DIGEST_SIZE),
  1648				},
  1649			},
  1650			.hash_mode = DRV_HASH_SHA384,
  1651			.hw_mode = DRV_HASH_HW_SHA512,
  1652			.inter_digestsize = SHA512_DIGEST_SIZE,
  1653			.min_hw_rev = CC_HW_REV_712,
  1654		},
  1655		{
  1656			.name = "sha512",
  1657			.driver_name = "sha512-ccree",
  1658			.mac_name = "hmac(sha512)",
  1659			.mac_driver_name = "hmac-sha512-ccree",
  1660			.blocksize = SHA512_BLOCK_SIZE,
  1661			.is_mac = true,
  1662			.template_ahash = {
  1663				.init = cc_hash_init,
  1664				.update = cc_hash_update,
  1665				.final = cc_hash_final,
  1666				.finup = cc_hash_finup,
  1667				.digest = cc_hash_digest,
  1668				.export = cc_hash_export,
  1669				.import = cc_hash_import,
  1670				.setkey = cc_hash_setkey,
  1671				.halg = {
  1672					.digestsize = SHA512_DIGEST_SIZE,
  1673					.statesize = CC_STATE_SIZE(SHA512_DIGEST_SIZE),
  1674				},
  1675			},
  1676			.hash_mode = DRV_HASH_SHA512,
  1677			.hw_mode = DRV_HASH_HW_SHA512,
  1678			.inter_digestsize = SHA512_DIGEST_SIZE,
  1679			.min_hw_rev = CC_HW_REV_712,
  1680		},
  1681		{
  1682			.name = "md5",
  1683			.driver_name = "md5-ccree",
  1684			.mac_name = "hmac(md5)",
  1685			.mac_driver_name = "hmac-md5-ccree",
  1686			.blocksize = MD5_HMAC_BLOCK_SIZE,
  1687			.is_mac = true,
  1688			.template_ahash = {
  1689				.init = cc_hash_init,
  1690				.update = cc_hash_update,
  1691				.final = cc_hash_final,
  1692				.finup = cc_hash_finup,
  1693				.digest = cc_hash_digest,
  1694				.export = cc_hash_export,
  1695				.import = cc_hash_import,
  1696				.setkey = cc_hash_setkey,
  1697				.halg = {
  1698					.digestsize = MD5_DIGEST_SIZE,
  1699					.statesize = CC_STATE_SIZE(MD5_DIGEST_SIZE),
  1700				},
  1701			},
  1702			.hash_mode = DRV_HASH_MD5,
  1703			.hw_mode = DRV_HASH_HW_MD5,
  1704			.inter_digestsize = MD5_DIGEST_SIZE,
  1705			.min_hw_rev = CC_HW_REV_630,
  1706		},
  1707		{
  1708			.name = "sm3",
  1709			.driver_name = "sm3-ccree",
  1710			.blocksize = SM3_BLOCK_SIZE,
  1711			.is_mac = false,
  1712			.template_ahash = {
  1713				.init = cc_hash_init,
  1714				.update = cc_hash_update,
  1715				.final = cc_hash_final,
  1716				.finup = cc_hash_finup,
  1717				.digest = cc_hash_digest,
  1718				.export = cc_hash_export,
  1719				.import = cc_hash_import,
  1720				.setkey = cc_hash_setkey,
  1721				.halg = {
  1722					.digestsize = SM3_DIGEST_SIZE,
  1723					.statesize = CC_STATE_SIZE(SM3_DIGEST_SIZE),
  1724				},
  1725			},
  1726			.hash_mode = DRV_HASH_SM3,
  1727			.hw_mode = DRV_HASH_HW_SM3,
  1728			.inter_digestsize = SM3_DIGEST_SIZE,
> 1729			.min_hw_rev = CC_HW_REV_713,
  1730		},
  1731		{
  1732			.mac_name = "xcbc(aes)",
  1733			.mac_driver_name = "xcbc-aes-ccree",
  1734			.blocksize = AES_BLOCK_SIZE,
  1735			.is_mac = true,
  1736			.template_ahash = {
  1737				.init = cc_hash_init,
  1738				.update = cc_mac_update,
  1739				.final = cc_mac_final,
  1740				.finup = cc_mac_finup,
  1741				.digest = cc_mac_digest,
  1742				.setkey = cc_xcbc_setkey,
  1743				.export = cc_hash_export,
  1744				.import = cc_hash_import,
  1745				.halg = {
  1746					.digestsize = AES_BLOCK_SIZE,
  1747					.statesize = CC_STATE_SIZE(AES_BLOCK_SIZE),
  1748				},
  1749			},
  1750			.hash_mode = DRV_HASH_NULL,
  1751			.hw_mode = DRV_CIPHER_XCBC_MAC,
  1752			.inter_digestsize = AES_BLOCK_SIZE,
  1753			.min_hw_rev = CC_HW_REV_630,
  1754		},
  1755		{
  1756			.mac_name = "cmac(aes)",
  1757			.mac_driver_name = "cmac-aes-ccree",
  1758			.blocksize = AES_BLOCK_SIZE,
  1759			.is_mac = true,
  1760			.template_ahash = {
  1761				.init = cc_hash_init,
  1762				.update = cc_mac_update,
  1763				.final = cc_mac_final,
  1764				.finup = cc_mac_finup,
  1765				.digest = cc_mac_digest,
  1766				.setkey = cc_cmac_setkey,
  1767				.export = cc_hash_export,
  1768				.import = cc_hash_import,
  1769				.halg = {
  1770					.digestsize = AES_BLOCK_SIZE,
  1771					.statesize = CC_STATE_SIZE(AES_BLOCK_SIZE),
  1772				},
  1773			},
  1774			.hash_mode = DRV_HASH_NULL,
  1775			.hw_mode = DRV_CIPHER_CMAC,
  1776			.inter_digestsize = AES_BLOCK_SIZE,
  1777			.min_hw_rev = CC_HW_REV_630,
  1778		},
  1779	};
  1780	
  1781	static struct cc_hash_alg *cc_alloc_hash_alg(struct cc_hash_template *template,
  1782						     struct device *dev, bool keyed)
  1783	{
  1784		struct cc_hash_alg *t_crypto_alg;
  1785		struct crypto_alg *alg;
  1786		struct ahash_alg *halg;
  1787	
  1788		t_crypto_alg = kzalloc(sizeof(*t_crypto_alg), GFP_KERNEL);
  1789		if (!t_crypto_alg)
  1790			return ERR_PTR(-ENOMEM);
  1791	
  1792		t_crypto_alg->ahash_alg = template->template_ahash;
  1793		halg = &t_crypto_alg->ahash_alg;
  1794		alg = &halg->halg.base;
  1795	
  1796		if (keyed) {
  1797			snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
  1798				 template->mac_name);
  1799			snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
  1800				 template->mac_driver_name);
  1801		} else {
  1802			halg->setkey = NULL;
  1803			snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
  1804				 template->name);
  1805			snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
  1806				 template->driver_name);
  1807		}
  1808		alg->cra_module = THIS_MODULE;
  1809		alg->cra_ctxsize = sizeof(struct cc_hash_ctx);
  1810		alg->cra_priority = CC_CRA_PRIO;
  1811		alg->cra_blocksize = template->blocksize;
  1812		alg->cra_alignmask = 0;
  1813		alg->cra_exit = cc_cra_exit;
  1814	
  1815		alg->cra_init = cc_cra_init;
  1816		alg->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
  1817	
  1818		t_crypto_alg->hash_mode = template->hash_mode;
  1819		t_crypto_alg->hw_mode = template->hw_mode;
  1820		t_crypto_alg->inter_digestsize = template->inter_digestsize;
  1821	
  1822		return t_crypto_alg;
  1823	}
  1824	
  1825	int cc_init_hash_sram(struct cc_drvdata *drvdata)
  1826	{
  1827		struct cc_hash_handle *hash_handle = drvdata->hash_handle;
  1828		cc_sram_addr_t sram_buff_ofs = hash_handle->digest_len_sram_addr;
  1829		unsigned int larval_seq_len = 0;
  1830		struct cc_hw_desc larval_seq[CC_DIGEST_SIZE_MAX / sizeof(u32)];
  1831		bool large_sha_supported = (drvdata->hw_rev >= CC_HW_REV_712);
> 1832		bool sm3_supported = (drvdata->hw_rev >= CC_HW_REV_713);
  1833		int rc = 0;
  1834	
  1835		/* Copy-to-sram digest-len */
  1836		cc_set_sram_desc(digest_len_init, sram_buff_ofs,
  1837				 ARRAY_SIZE(digest_len_init), larval_seq,
  1838				 &larval_seq_len);
  1839		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1840		if (rc)
  1841			goto init_digest_const_err;
  1842	
  1843		sram_buff_ofs += sizeof(digest_len_init);
  1844		larval_seq_len = 0;
  1845	
  1846		if (large_sha_supported) {
  1847			/* Copy-to-sram digest-len for sha384/512 */
  1848			cc_set_sram_desc(digest_len_sha512_init, sram_buff_ofs,
  1849					 ARRAY_SIZE(digest_len_sha512_init),
  1850					 larval_seq, &larval_seq_len);
  1851			rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1852			if (rc)
  1853				goto init_digest_const_err;
  1854	
  1855			sram_buff_ofs += sizeof(digest_len_sha512_init);
  1856			larval_seq_len = 0;
  1857		}
  1858	
  1859		/* The initial digests offset */
  1860		hash_handle->larval_digest_sram_addr = sram_buff_ofs;
  1861	
  1862		/* Copy-to-sram initial SHA* digests */
  1863		cc_set_sram_desc(md5_init, sram_buff_ofs, ARRAY_SIZE(md5_init),
  1864				 larval_seq, &larval_seq_len);
  1865		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1866		if (rc)
  1867			goto init_digest_const_err;
  1868		sram_buff_ofs += sizeof(md5_init);
  1869		larval_seq_len = 0;
  1870	
  1871		cc_set_sram_desc(sha1_init, sram_buff_ofs,
  1872				 ARRAY_SIZE(sha1_init), larval_seq,
  1873				 &larval_seq_len);
  1874		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1875		if (rc)
  1876			goto init_digest_const_err;
  1877		sram_buff_ofs += sizeof(sha1_init);
  1878		larval_seq_len = 0;
  1879	
  1880		cc_set_sram_desc(sha224_init, sram_buff_ofs,
  1881				 ARRAY_SIZE(sha224_init), larval_seq,
  1882				 &larval_seq_len);
  1883		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1884		if (rc)
  1885			goto init_digest_const_err;
  1886		sram_buff_ofs += sizeof(sha224_init);
  1887		larval_seq_len = 0;
  1888	
  1889		cc_set_sram_desc(sha256_init, sram_buff_ofs,
  1890				 ARRAY_SIZE(sha256_init), larval_seq,
  1891				 &larval_seq_len);
  1892		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1893		if (rc)
  1894			goto init_digest_const_err;
  1895		sram_buff_ofs += sizeof(sha256_init);
  1896		larval_seq_len = 0;
  1897	
  1898		if (sm3_supported) {
  1899			cc_set_sram_desc(sm3_init, sram_buff_ofs,
  1900					 ARRAY_SIZE(sm3_init), larval_seq,
  1901					 &larval_seq_len);
  1902			rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1903			if (rc)
  1904				goto init_digest_const_err;
  1905			sram_buff_ofs += sizeof(sm3_init);
  1906			larval_seq_len = 0;
  1907		}
  1908	
  1909		if (large_sha_supported) {
  1910			cc_set_sram_desc((u32 *)sha384_init, sram_buff_ofs,
  1911					 (ARRAY_SIZE(sha384_init) * 2), larval_seq,
  1912					 &larval_seq_len);
  1913			rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1914			if (rc)
  1915				goto init_digest_const_err;
  1916			sram_buff_ofs += sizeof(sha384_init);
  1917			larval_seq_len = 0;
  1918	
  1919			cc_set_sram_desc((u32 *)sha512_init, sram_buff_ofs,
  1920					 (ARRAY_SIZE(sha512_init) * 2), larval_seq,
  1921					 &larval_seq_len);
  1922			rc = send_request_init(drvdata, larval_seq, larval_seq_len);
  1923			if (rc)
  1924				goto init_digest_const_err;
  1925		}
  1926	
  1927	init_digest_const_err:
  1928		return rc;
  1929	}
  1930	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
